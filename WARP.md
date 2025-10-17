# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

This is a Zed editor extension that provides ObjectScript language support for InterSystems IRIS development. The extension uses the tree-sitter-objectscript grammar to provide syntax highlighting and code injections for `.cls` files.

## Architecture

### Extension Structure
- `extension.toml`: Main extension configuration defining the extension metadata and grammar references
- `languages/objectscript_udl/`: Language-specific configuration for ObjectScript UDL (Unified Data Language)
  - `config.toml`: Language configuration (file associations, commenting, brackets)
  - `highlights.scm`: Tree-sitter syntax highlighting queries
  - `injections.scm`: Code injection patterns for embedded languages (SQL, HTML, JavaScript, CSS, XML, Python, Markdown)
  - `locals.scm`: Local variable scoping (currently empty)

### Key Features
- Syntax highlighting for ObjectScript `.cls` files
- Multi-language code injection support for embedded languages within ObjectScript
- Support for ObjectScript-specific constructs like system variables, functions, and class definitions
- Comment handling for multiple ObjectScript comment styles (`//`, `;`, `;;`, `#;`)

### Tree-sitter Grammar
The extension relies on the external `tree-sitter-objectscript` grammar from InterSystems. The grammar is fetched from GitHub at build time (commit: `320a28654593428e5a7da76b034ce9d5a1cc528a`).

## Development Commands

Since this is a Zed extension, development follows the Zed extension development workflow:

### Testing the Extension
```bash
# Install the extension locally in Zed's development mode
# No specific build command - Zed handles tree-sitter compilation automatically
```

### Debugging
To enable detailed logging for language and extension debugging:
```bash
# On macOS/Linux:
RUST_LOG="language,extension=trace" zed

# On Windows (PowerShell):
$env:RUST_LOG = "language,extension=trace"
```

## File Types and Language Injection

The extension supports embedded language syntax highlighting through tree-sitter injections:

### Primary Language
- `.cls` files: ObjectScript classes with UDL syntax

### Embedded Languages
When editing ObjectScript files, these embedded languages are automatically detected and highlighted:
- **SQL**: Within `&sql()` and `#sql()` blocks
- **HTML**: Within `&html<>` blocks  
- **JavaScript**: Within `&js<>` blocks
- **XML**: Within `&xml<>` and XDATA blocks with `text/xml` MimeType
- **CSS**: Within XDATA blocks with `text/css` MimeType
- **JSON**: Within XDATA blocks with `application/json` MimeType
- **Markdown**: Within XDATA blocks with `text/markdown` MimeType
- **Python**: Within methods with `Language = "python"` keyword

## Contributing Guidelines

### Commit Style
This project uses [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) for commit messages.

### Tree-sitter Query Files
When modifying `.scm` files:
- `highlights.scm`: Contains syntax highlighting patterns for ObjectScript constructs
- `injections.scm`: Defines how embedded languages are detected and injected
- Use descriptive comments to explain complex query patterns
- Test changes by enabling RUST_LOG debugging to catch bad `.scm` rules

### Performance Notes
- ObjectScript grammar compilation can take 15-60 seconds in Zed's WASM environment
- The grammar supports sophisticated language constructs that require complex parsing

## Important Files to Know

- `extension.toml`: Extension metadata and grammar configuration
- `languages/objectscript_udl/config.toml`: Core language settings for ObjectScript
- `languages/objectscript_udl/highlights.scm`: All syntax highlighting rules (200+ lines)
- `languages/objectscript_udl/injections.scm`: Multi-language injection patterns (130+ lines)