#!/usr/bin/env bash
# Install altoviz CLI
# Usage: curl -fsSL https://cli.altoviz.com | bash
#        curl -fsSL https://cli.altoviz.com | ALTOVIZ_VERSION=1.2.0 bash
#        curl -fsSL https://cli.altoviz.com | ALTOVIZ_INSTALL_DIR=~/.local/bin bash
set -euo pipefail

REPO="altoviz/cli"
VERSION="${ALTOVIZ_VERSION:-latest}"
INSTALL_DIR="${ALTOVIZ_INSTALL_DIR:-/usr/local/bin}"

# ── Detect OS and architecture ─────────────────────────────────────────────────
OS=$(uname -s)
ARCH=$(uname -m)

case "$OS" in
  Linux*)  OS_KEY="linux" ;;
  Darwin*) OS_KEY="osx" ;;
  *)
    echo "error: unsupported OS '$OS'" >&2
    echo "       Download manually from https://github.com/${REPO}/releases" >&2
    exit 1
    ;;
esac

case "$ARCH" in
  x86_64|amd64) ARCH_KEY="x64" ;;
  arm64|aarch64) ARCH_KEY="arm64" ;;
  *)
    echo "error: unsupported architecture '$ARCH'" >&2
    exit 1
    ;;
esac

RID="${OS_KEY}-${ARCH_KEY}"

# ── Resolve version ────────────────────────────────────────────────────────────
if [ "$VERSION" = "latest" ]; then
  VERSION=$(curl -fsSL "https://api.github.com/repos/${REPO}/releases/latest" \
    | grep '"tag_name"' | head -1 | cut -d'"' -f4)
  [ -z "$VERSION" ] && { echo "error: could not determine latest version" >&2; exit 1; }
fi
VERSION_BARE="${VERSION#v}"

# ── Download ───────────────────────────────────────────────────────────────────
ARCHIVE="altoviz-${RID}.tar.gz"
URL="https://github.com/${REPO}/releases/download/${VERSION}/${ARCHIVE}"
TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

echo "Downloading altoviz ${VERSION_BARE} for ${RID}…"
curl -fsSL --progress-bar "$URL" -o "${TMPDIR}/${ARCHIVE}"

# ── Verify checksum (if checksums.txt is available) ────────────────────────────
CHECKSUMS_URL="https://github.com/${REPO}/releases/download/${VERSION}/checksums.txt"
if curl -fsSL "$CHECKSUMS_URL" -o "${TMPDIR}/checksums.txt" 2>/dev/null; then
  (cd "$TMPDIR" && grep "$ARCHIVE" checksums.txt | sha256sum --check --quiet)
  echo "Checksum verified."
fi

# ── Extract and install ────────────────────────────────────────────────────────
tar xzf "${TMPDIR}/${ARCHIVE}" -C "$TMPDIR"

BINARY="${TMPDIR}/altoviz"
chmod +x "$BINARY"

# Use sudo only if the install dir is not writable by current user
if [ -w "$INSTALL_DIR" ]; then
  install -m 755 "$BINARY" "${INSTALL_DIR}/altoviz"
else
  sudo install -m 755 "$BINARY" "${INSTALL_DIR}/altoviz"
fi

echo ""
echo "altoviz installed to ${INSTALL_DIR}/altoviz"
echo ""
"${INSTALL_DIR}/altoviz" about
echo ""
echo "Run 'altoviz config create' to set your API key."
