<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="assets/altoviz-logo-ext-white.svg" />
    <img src="assets/altoviz-logo-ext-violet.svg" width="200" alt="Altoviz" />
  </picture>
</p>

<h1 align="center">Altoviz CLI</h1>

<p align="center">
  Command-line interface for <a href="https://www.altoviz.com">Altoviz</a> — the French SaaS invoicing &amp; accounting platform for small businesses and freelancers.<br/>
  Built for humans, automation processes and LLMs alike.
</p>

<p align="center">
  </a>
  <img src="https://img.shields.io/badge/.NET-10.0-512bd4" alt=".NET 10" />
  <img src="https://img.shields.io/badge/platforms-macOS%20%7C%20Linux%20%7C%20Windows%20(x64%2Farm64)-blue" alt="Platforms" />
  <a href="https://github.com/altoviz/homebrew-tap">
    <img src="https://img.shields.io/badge/homebrew-altoviz%2Ftap-FBB040?logo=homebrew" alt="Homebrew tap" />
  </a>
  <a href="https://community.chocolatey.org/packages/altoviz">
    <img src="https://img.shields.io/chocolatey/v/altoviz?logo=chocolatey&color=80B5E3" alt="Chocolatey" />
  </a>
</p>

---

## Overview

`altoviz` is a self-contained CLI that wraps the [Altoviz REST API](https://api.altoviz.com). It lets you manage customers, suppliers, invoices, quotes, products, receipts, and more — directly from the terminal or from an LLM agent.

Key highlights:

- **No runtime required** — single binary for macOS, Linux, and Windows
- **9 output formats** — table (default), JSON, YAML, Markdown, CSV, TSV
- **Shell completions** — bash, zsh, fish, PowerShell
- **Secure credential storage** — API key stored in the OS keychain (macOS Keychain, Windows Credential Manager, Linux Secret Service)
- **Multiple profiles** — switch between environments with `--profile`
- **Scriptable** — pipe JSON in with `--file -`, control columns with `--columns`, page with `--all-pages`

---

## Installation

### macOS

```sh
brew trust altoviz/tap && brew install altoviz/tap/altoviz
```

### Linux

```sh
# Homebrew
brew trust altoviz/tap && brew install altoviz/tap/altoviz

# One-liner installer
curl -fsSL https://raw.githubusercontent.com/altoviz/cli/main/install.sh | sh

# Debian / Ubuntu
sudo apt install ./altoviz_<version>_amd64.deb

# Fedora / RHEL
sudo rpm -i altoviz-<version>-1.x86_64.rpm
```

### Windows

```powershell
## WinGet
winget install Altoviz.CLI

## Chocolatey
choco install altoviz
```

**Manual install:** download the zip from [Releases](https://github.com/altoviz/cli/releases), extract and have fun.

---

## Quick Start

```sh
# Store your API key (saved to OS keychain)
altoviz config create

# Add a named profile for a test company with interactive experience
altoviz config create my_test_company

# Add a named profile for a test company with args
 altoviz config create my_test_company --api-key={YOUR_API_KEY}

# — or pass it inline / via environment variable
export ALTOVIZ_CLI_API_KEY=your_key_here

# — or pass it as an arg on every command
altoviz invoice list --api-key={YOUR_API_KEY}


# List invoices
altoviz invoice list

# List invoices as JSON
altoviz invoice list --json

# List invoices as Markdown
altoviz invoice list --output markdown

# Fetch a single customer as colored JSON
altoviz customer get 42 --cjson

# Use a specific profile
altoviz --profile staging customers list

# Export this year's invoices to CSV
altoviz export invoices --from 2026-01-01 --to 2026-12-31
```

---

## Commands

### General

| Command                      | Description                                                              |
| ---------------------------- | ------------------------------------------------------------------------ |
| `altoviz about`              | Display version, website, and copyright                                  |
| `altoviz version [--check]`  | Print current version; `--check` compares with the latest GitHub release |
| `altoviz completion <shell>` | Emit a completion script for `bash`, `zsh`, `fish`, or `pwsh`            |

### Configuration

| Command                   | Description                                        |
| ------------------------- | -------------------------------------------------- |
| `config list`             | List all configured profiles                       |
| `config get [profile]`    | Display a profile's endpoint and key status        |
| `config create [profile]` | Add or update a profile (interactive or via flags) |
| `config delete [profile]` | Remove a profile and its stored credentials        |
| `config reset`            | Delete all profiles and credentials                |

`config create` accepts `--api-key` and `--endpoint` flags for non-interactive use. When run interactively it prompts with a link to [app.altoviz.com/go/settings/apis](https://app.altoviz.com/go/settings/apis).

### Customers

| Command                | Description                                                      |
| ---------------------- | ---------------------------------------------------------------- |
| `customer list`        | List customers (supports `--query`, `--order-by`, `--all-pages`) |
| `customer get <id>`    | Get a customer by ID                                             |
| `customer find`        | Find a customer by `--email`, `--number`, or `--internal-id`     |
| `customer create`      | Create a customer (flags or `--file <json/yaml>`)                |
| `customer update <id>` | Update a customer (merges flag changes onto existing record)     |
| `customer delete <id>` | Delete a customer (prompts for confirmation)                     |

### Suppliers

| Command                | Description                                                                  |
| ---------------------- | ---------------------------------------------------------------------------- |
| `supplier list`        | List suppliers                                                               |
| `supplier get <id>`    | Get a supplier by ID                                                         |
| `supplier find`        | Find a supplier by `--email` or `--internal-id`                              |
| `supplier create`      | Create a supplier (`--name`, `--payment-method`, person fields, or `--file`) |
| `supplier update <id>` | Update a supplier                                                            |
| `supplier delete <id>` | Delete a supplier                                                            |

### Contacts

| Command               | Description                                                                                |
| --------------------- | ------------------------------------------------------------------------------------------ |
| `contact list`        | List contacts                                                                              |
| `contact get <id>`    | Get a contact by ID                                                                        |
| `contact find`        | Find by `--email` or `--internal-id`                                                       |
| `contact create`      | Create a contact (`--company-name`, `--function`, `--service`, person fields, or `--file`) |
| `contact update <id>` | Update a contact                                                                           |
| `contact delete <id>` | Delete a contact                                                                           |

### Colleagues

| Command                 | Description                                                                            |
| ----------------------- | -------------------------------------------------------------------------------------- |
| `colleague list`        | List colleagues                                                                        |
| `colleague get <id>`    | Get a colleague by ID                                                                  |
| `colleague find`        | Find by `--email`, `--number`, or `--internal-id`                                      |
| `colleague create`      | Create a colleague (`--name`, `--is-partner`, `--user-id`, person fields, or `--file`) |
| `colleague update <id>` | Update a colleague                                                                     |
| `colleague delete <id>` | Delete a colleague                                                                     |

### Products

| Command                      | Description                                                           |
| ---------------------------- | --------------------------------------------------------------------- |
| `product list [--family-id]` | List products, optionally filtered by family                          |
| `product get <id>`           | Get a product by ID                                                   |
| `product find`               | Find by `--reference` or `--internal-id`                              |
| `product create`             | Create a product (`--name`, `--unit-price`, `--type`, …, or `--file`) |
| `product update <id>`        | Update a product                                                      |
| `product delete <id>`        | Delete a product                                                      |
| `product family list`        | List product families                                                 |
| `product family get <id>`    | Get a product family                                                  |
| `product family create`      | Create a product family (`--file` required)                           |
| `product family delete <id>` | Delete a product family                                               |

### Invoices

| Command                  | Description                                                   |
| ------------------------ | ------------------------------------------------------------- |
| `invoice list`           | List invoices (`--from`, `--to`, `--customer-id`, `--status`) |
| `invoice get <id>`       | Get an invoice by ID                                          |
| `invoice find`           | Find by `--number` or `--internal-id`                         |
| `invoice create`         | Create an invoice (`--file` required)                         |
| `invoice update <id>`    | Update a draft invoice                                        |
| `invoice delete <id>`    | Delete an invoice                                             |
| `invoice finalize <id>`  | Finalize (issue) an invoice                                   |
| `invoice send <id>`      | Send an invoice by email                                      |
| `invoice mark-paid <id>` | Mark an invoice as paid                                       |
| `invoice download <id>`  | Download the invoice PDF (`--file <path>`)                    |

### Quotes

| Command               | Description                              |
| --------------------- | ---------------------------------------- |
| `quote list`          | List quotes                              |
| `quote get <id>`      | Get a quote by ID                        |
| `quote find`          | Find by `--number` or `--internal-id`    |
| `quote create`        | Create a quote (`--file` required)       |
| `quote delete <id>`   | Delete a quote                           |
| `quote send <id>`     | Send a quote by email                    |
| `quote download <id>` | Download the quote PDF (`--file <path>`) |

### Credit Notes

| Command                     | Description                                    |
| --------------------------- | ---------------------------------------------- |
| `credit list`               | List credit notes                              |
| `credit get <id>`           | Get a credit note by ID                        |
| `credit find`               | Find by `--number` or `--internal-id`          |
| `credit create`             | Create a credit note (`--file` required)       |
| `credit update <id>`        | Update a draft credit note                     |
| `credit delete <id>`        | Delete a credit note                           |
| `credit finalize <id>`      | Finalize a credit note                         |
| `credit send <id>`          | Send a credit note by email                    |
| `credit mark-refunded <id>` | Mark a credit note as refunded                 |
| `credit download <id>`      | Download the credit note PDF (`--file <path>`) |

### Receipts

| Command               | Description                          |
| --------------------- | ------------------------------------ |
| `receipt list`        | List receipts                        |
| `receipt get <id>`    | Get a receipt by ID                  |
| `receipt find`        | Find by `--internal-id`              |
| `receipt create`      | Create a receipt (`--file` required) |
| `receipt update <id>` | Update a receipt                     |
| `receipt delete <id>` | Delete a receipt                     |

### Webhooks

| Command                      | Description                                                                          |
| ---------------------------- | ------------------------------------------------------------------------------------ |
| `webhook list`               | List webhooks                                                                        |
| `webhook create`             | Create a webhook (`--name`, `--url`, `--type`, optional `--secret-key`, or `--file`) |
| `webhook delete <id-or-url>` | Delete a webhook by numeric ID or URL                                                |

### Exports

All export commands accept `--from` / `--to` (date range), `--format` (Excel, EuropeanCsv, AmericanCsv, Tsv, Json, Markdown), `--sheets` (Summary, Detail, Analysis, All), and `--out <file>` to save to disk.

| Export type                | Description                         |
| -------------------------- | ----------------------------------- |
| `export invoices`          | Sales invoices                      |
| `export quotes`            | Sales quotes                        |
| `export credits`           | Credit notes                        |
| `export products`          | Product catalog                     |
| `export customers`         | Customer list                       |
| `export suppliers`         | Supplier list                       |
| `export receipts-book`     | Receipts journal                    |
| `export expenses-book`     | Expenses journal                    |
| `export bank-transactions` | Bank transactions (requires `--id`) |
| `export expense-charges`   | Expense charges                     |
| `export expense-reports`   | Expense reports (`--colleague-id`)  |
| `export settlements`       | Settlements                         |
| `export commitments`       | Commitments                         |

### Statistics

| Command                            | Description                                                     |
| ---------------------------------- | --------------------------------------------------------------- |
| `stats by-month [--year]`          | Monthly breakdown for a given year (default: current year)      |
| `stats turnover`                   | Sales turnover vs previous period                               |
| `stats evolution [--by] [--years]` | Turnover evolution by customer, supplier, product, or colleague |

### Reference Data

| Command                    | Description                                       |
| -------------------------- | ------------------------------------------------- |
| `vats`                     | List VAT rates                                    |
| `units`                    | List units of measure                             |
| `classifications [--type]` | List classifications, optionally filtered by type |
| `settings`                 | Get account settings                              |

---

## Output Formats

Use `--output` / `-o` on any command, or the shorthand flags below:

| Flag      | Equivalent              | Description                              |
| --------- | ----------------------- | ---------------------------------------- |
| _(none)_  | `--output table`        | Bordered table, auto-fits terminal width |
| `--json`  | `--output json`         | Pretty-printed JSON                      |
| `--yaml`  | `--output yaml`         | YAML                                     |
| `--cjson` | `--output colored-json` | Syntax-highlighted JSON (ANSI colors)    |
| `--md`    | `--output markdown`     | Pipe-delimited Markdown table            |
| `--csv`   | `--output csv-us`       | CSV with `,` separator                   |
| `--tsv`   | `--output tsv`          | Tab-separated values                     |

Additional `--output` values: `compact-json`, `csv-eu` (`;` separator).

Control which columns appear with `--columns id|name|email` (pipe-separated dot-paths).

---

## Global Options

These options are available on every command:

| Option        | Short | Description                                                                         |
| ------------- | ----- | ----------------------------------------------------------------------------------- |
| `--profile`   | `-p`  | Profile to use (env: `ALTOVIZ_CLI_PROFILE`, default: `default`)                     |
| `--api-key`   |       | Override API key (env: `ALTOVIZ_CLI_API_KEY`)                                       |
| `--endpoint`  |       | Override base URL (env: `ALTOVIZ_CLI_ENDPOINT`, default: `https://api.altoviz.com`) |
| `--output`    | `-o`  | Output format (see above)                                                           |
| `--json`      |       | Shorthand for `--output json`                                                       |
| `--yaml`      |       | Shorthand for `--output yaml`                                                       |
| `--cjson`     |       | Shorthand for `--output colored-json`                                               |
| `--md`        |       | Shorthand for `--output markdown`                                                   |
| `--csv`       |       | Shorthand for `--output csv-us`                                                     |
| `--tsv`       |       | Shorthand for `--output tsv`                                                        |
| `--columns`   |       | Pipe-separated dot-path column list                                                 |
| `--file`      | `-f`  | JSON/YAML input file, or `-` for stdin                                              |
| `--verbose`   |       | Print HTTP request/response to stderr                                               |
| `--no-color`  |       | Disable ANSI colors                                                                 |
| `--quiet`     | `-q`  | Suppress all output except errors                                                   |
| `--yes`       | `-y`  | Skip confirmation prompts                                                           |
| `--show-time` |       | Include time component in date columns                                              |

---

## Exit Codes

| Code | Meaning                                       |
| ---- | --------------------------------------------- |
| `0`  | Success                                       |
| `1`  | General failure (network error, server error) |
| `2`  | Usage error (invalid arguments or options)    |
| `3`  | Resource not found (HTTP 404)                 |
| `4`  | Permission denied (HTTP 401 / 403)            |
| `5`  | Conflict (HTTP 409 — resource already exists) |

When using `--output json`, API errors are also written to stdout as a structured object:

```json
{
  "error": true,
  "statusCode": 404,
  "detail": { "message": "Customer not found" }
}
```

---

## Configuration

### Profiles

The CLI supports named profiles so you can switch between different environments or accounts:

```sh
# Add or update the default profile
altoviz config create

# Add a staging profile
altoviz config create staging --endpoint https://api.staging.altoviz.com

# Use a profile for a single command
altoviz --profile staging invoice list

# Set the active profile for the session
export ALTOVIZ_CLI_PROFILE=staging
```

### Credential storage

API keys are stored securely in the OS keychain — no plain text on disk:

| Platform | Store                      |
| -------- | -------------------------- |
| macOS    | Keychain                   |
| Windows  | Credential Manager         |
| Linux    | Secret Service (libsecret) |
| WSL      | Windows Credential Manager |

If no keychain is available, the key falls back to the config file with a warning.

### Credential resolution order

For each command, credentials are resolved in priority order:

1. `--api-key` / `--endpoint` CLI flags
2. `ALTOVIZ_CLI_API_KEY` / `ALTOVIZ_CLI_ENDPOINT` environment variables
3. OS keychain (keyed by profile name)
4. `~/.altoviz/cli.yaml` config file

### Config file format

`~/.altoviz/cli.yaml` uses an INI-style format with one section per profile:

```ini
[default]
apikey={YOUR_API_KEY}

[my_other_company]
apikey={YOUR_OTHER_API_KEY}
```

API keys are omitted from the file when the OS keychain is available.

---

## Links

- Website: [altoviz.com](https://altoviz.com)
- API documentation: [api.altoviz.com](https://developer.altoviz.com)
- API key settings: [app.altoviz.com/go/settings/apis](https://app.altoviz.com/go/settings/apis)
- Releases: [github.com/altoviz/cli/releases](https://github.com/altoviz/cli/releases)

---

<p align="center">
  <sub>© 2024–2026 <a href="https://altoviz.com">Altoviz</a></sub>
</p>
