# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview
This is a Neovim configuration using Lua and the Lazy plugin manager. The configuration is based on a YouTube tutorial (https://youtu.be/IZnhl121yo0) and focuses on a minimal, modern setup with essential plugins.

## Commands

### Plugin Management
- `:Lazy` - Open Lazy plugin manager interface
- `:Lazy sync` - Sync plugins (install missing, update existing)
- `:Lazy check` - Check for plugin updates
- `:Lazy clean` - Remove unused plugins

### LSP and Diagnostics
- `:LspInfo` - Show LSP server information
- `:LspRestart` - Restart LSP servers
- `<leader>q` - Open diagnostic quickfix list

### Formatting
The configuration uses conform.nvim for formatting:
- Lua files: stylua
- Go files: goimports, golines, gofmt
Format manually with `:ConformInfo` and conform commands

### Treesitter
- `:TSUpdate` - Update treesitter parsers
- `:TSInstall <language>` - Install specific language parser

## Architecture

### File Structure
```
init.lua                 # Main entry point - loads all modules
lua/
├── config/             # Core configuration
│   ├── options.lua     # Vim options and settings
│   ├── keymaps.lua     # Key mappings
│   └── autocmds.lua    # Auto commands
├── core/              # Core functionality
│   ├── lazy.lua       # Lazy plugin manager setup
│   └── lsp.lua        # LSP configuration
└── plugins/           # Plugin configurations
    ├── blink.lua      # Blink completion
    ├── colorschemes.lua
    ├── conform.lua    # Code formatting
    ├── lazydev.lua    # Lua development
    ├── telescope.lua  # Fuzzy finder
    ├── treesitter.lua # Syntax highlighting
    ├── vim-sleuth.lua # Automatic indentation
    └── which-key.lua  # Key binding help
lsp/                   # LSP server configurations
├── lua_ls.lua        # Lua language server
└── sourcekit_lsp.lua # Swift language server
```

### Key Configuration Details
- **Leader key**: Space (`<leader>`)
- **Plugin manager**: Lazy.nvim with lazy loading
- **LSP servers**: lua_ls, sourcekit_lsp (enabled via vim.lsp.enable())
- **Completion**: Blink completion engine
- **Fuzzy finder**: Telescope with fzf-native extension
- **Formatting**: conform.nvim with stylua for Lua, Go formatters for Go
- **Syntax highlighting**: Treesitter with auto-install enabled

### Important Keybindings
- `<leader>e` - Open file explorer (`:Ex`)
- `<leader>sf` - Search files (Telescope)
- `<leader>sg` - Live grep (Telescope)
- `<leader>tt` - Open terminal
- `<leader>tv` - Open vertical terminal
- `<leader>tf` - Open floating terminal
- `<C-h/j/k/l>` - Navigate between windows

### Plugin Loading Strategy
The configuration uses lazy loading extensively:
- Most plugins load on specific events (`VimEnter`, `BufReadPost`, etc.)
- LSP and completion are configured to activate when needed
- Treesitter parsers are auto-installed for supported languages

## Development Notes
- The configuration is optimized for Lua and Swift development
- Uses Nerd Font icons (requires proper font installation)
- Diagnostic signs are customized with specific icons
- Terminal integration with multiple opening modes (horizontal, vertical, floating)