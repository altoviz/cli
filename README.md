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
</p>

---

## Overview

`altoviz` is a self-contained CLI that wraps the [Altoviz REST API](https://api.altoviz.com). It lets you manage customers, suppliers, invoices, quotes, products, receipts, and more — directly from the terminal or from an LLM agent.

Key highlights:

- **No runtime required** — single binary for macOS, Linux, and Windows
- **9 output formats** — table (default), JSON, YAML, Markdown, CSV, TSV
- **Shell completions** — bash, zsh, fish, PowerShell
- **Flexible auth** — env var, config file, or `--api-key` flag
- **Scriptable** — pipe JSON in with `--file -`, control columns with `--columns`, page with `--all-pages`

---

## Installation

### macOS

```sh
brew install altoviz/tap/altoviz
```

### Linux

```sh
# One-liner installer
curl -fsSL https://raw.githubusercontent.com/altoviz/cli/main/install.sh | sh

# Debian / Ubuntu
sudo apt install ./altoviz_<version>_amd64.deb

# Fedora / RHEL
sudo rpm -i altoviz-<version>-1.x86_64.rpm
```

### Windows

```powershell
winget install Altoviz.CLI
```

**Manual install:** download the zip from [Releases](https://github.com/altoviz/cli/releases), extract, and add the folder to your `PATH`.

---

## Quick Start

```sh
# Store your API key
altoviz configure

# — or pass it inline / via environment variable
export ALTOVIZ_API_KEY=your_key_here

# Verify connectivity
altoviz hello

# List invoices
altoviz invoice list

# Fetch a single customer as JSON
altoviz customer get 42 --output json

# Export this year's invoices to CSV
altoviz export invoices --from 2026-01-01 --to 2026-12-31
```

---

## Commands

### General

| Command                      | Description                                                              |
| ---------------------------- | ------------------------------------------------------------------------ |
| `altoviz hello`              | Test the API key and display connection info                             |
| `altoviz configure`          | Save API key and endpoint to `~/.altoviz/cli.yaml`                       |
| `altoviz version [--check]`  | Print current version; `--check` compares with the latest GitHub release |
| `altoviz completion <shell>` | Emit a completion script for `bash`, `zsh`, `fish`, or `pwsh`            |
| `altoviz about`              | Display version, website, and copyright                                  |

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

| Command                        | Description                                       |
| ------------------------------ | ------------------------------------------------- |
| `ref vats`                     | List VAT rates                                    |
| `ref units`                    | List units of measure                             |
| `ref classifications [--type]` | List classifications, optionally filtered by type |
| `ref settings`                 | Get account settings                              |

---

## Output Formats

Use `--output` / `-o` on any command:

| Value               | Description                                    |
| ------------------- | ---------------------------------------------- |
| `table` _(default)_ | Bordered ASCII table, auto-fits terminal width |
| `json`              | Pretty-printed JSON                            |
| `compact-json`      | Single-line JSON                               |
| `colored-json`      | Syntax-highlighted JSON (ANSI colors)          |
| `yaml`              | YAML                                           |
| `markdown`          | Pipe-delimited Markdown table                  |
| `csv-eu`            | CSV with `;` separator                         |
| `csv-us`            | CSV with `,` separator                         |
| `tsv`               | Tab-separated values                           |

Control which columns appear with `--columns id|name|email` (pipe-separated dot-paths).

---

## Global Options

These options are available on every command:

| Option        | Short | Description                                            |
| ------------- | ----- | ------------------------------------------------------ |
| `--api-key`   |       | Override API key (env: `ALTOVIZ_API_KEY`)              |
| `--endpoint`  |       | Override base URL (default: `https://api.altoviz.com`) |
| `--output`    | `-o`  | Output format (see above)                              |
| `--columns`   |       | Pipe-separated dot-path column list                    |
| `--file`      | `-f`  | JSON/YAML input file, or `-` for stdin                 |
| `--verbose`   |       | Print HTTP request/response to stderr                  |
| `--no-color`  |       | Disable ANSI colors                                    |
| `--quiet`     | `-q`  | Suppress all output except errors                      |
| `--yes`       | `-y`  | Skip confirmation prompts                              |
| `--show-time` |       | Include time component in date columns                 |

---

## Configuration

Credentials are resolved in this order (highest priority first):

1. `--api-key` CLI flag
2. `ALTOVIZ_API_KEY` environment variable
3. `~/.altoviz/cli.yaml` config file

Run `altoviz configure` to create or update the config file interactively. The file format is:

```yaml
apiKey: your_key_here
endpoint: https://api.altoviz.com # optional
```

---

## Links

- Website: [altoviz.com](https://www.altoviz.com)
- API documentation: [api.altoviz.com](https://api.altoviz.com)
- Releases: [github.com/altoviz/cli/releases](https://github.com/altoviz/cli/releases)

---

<p align="center">
  <sub>© 2024–2026 <a href="https://www.altoviz.com">Altoviz</a></sub>
</p>
