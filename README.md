# KmilleNvim
![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white) 
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)
<a href="https://neovim.io/"><img src="https://neovim.io/logos/neovim-mark-flat.png" align="right" width="80"/></a>

This is a Neovim configuration using [Lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager, optimized for PHP/Laravel development with modern IDE-like features.

## Installed Plugins

### Colorscheme
- **[tokyonight.nvim](https://github.com/folke/tokyonight.nvim)** - A clean, dark Neovim theme with multiple variants

### UI & Navigation
- **[which-key.nvim](https://github.com/folke/which-key.nvim)** - Displays a popup with possible keybindings when you start typing a command
- **[neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)** - Modern file explorer sidebar with git integration and file filtering
  - Dependencies: [plenary.nvim](https://github.com/nvim-lua/plenary.nvim), [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons), [nui.nvim](https://github.com/MunifTanjim/nui.nvim)
- **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** - Highly extendable fuzzy finder for files, grep, buffers, and more

### Syntax & Highlighting
- **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Advanced syntax highlighting and code parsing (configured for Lua, Bash, Python, JavaScript, HTML, CSS, JSON, PHP, Blade)
- **[vim-blade](https://github.com/jwalton512/vim-blade)** - Syntax highlighting for Laravel Blade templates
- **[tree-sitter-blade](https://github.com/EmranMR/tree-sitter-blade)** - Treesitter grammar for Blade templates with enhanced highlighting

### Autocompletion
- **[nvim-cmp](https://github.com/hrsh7th/nvim-cmp)** - VSCode-like autocompletion engine
  - **[cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)** - LSP completion source
  - **[cmp-buffer](https://github.com/hrsh7th/cmp-buffer)** - Buffer words completion
  - **[cmp-path](https://github.com/hrsh7th/cmp-path)** - Filesystem path completion
  - **[cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline)** - Command line completion
  - **[LuaSnip](https://github.com/L3MON4D3/LuaSnip)** - Snippet engine
  - **[cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)** - LuaSnip completion source
  - **[lspkind-nvim](https://github.com/onsails/lspkind-nvim)** - VSCode-like pictograms for completion items

### LSP & Language Support
- **[mason.nvim](https://github.com/williamboman/mason.nvim)** - Package manager for LSP servers, linters, and formatters
- **[mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)** - Bridge between mason and lspconfig
- **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - Quickstart configs for Neovim LSP
  - Configured with Intelephense for PHP
  - Configured with Laravel Dev Tools for Blade templates
- **[laravel.nvim](https://github.com/adibhanna/laravel.nvim)** - Laravel-specific features and commands

### Editor Enhancements
- **[nvim-autopairs](https://github.com/windwp/nvim-autopairs)** - Automatically closes brackets, quotes, and other pairs
- **[autosave.nvim](https://github.com/0x00-ketsu/autosave.nvim)** - Automatically saves files after changes with configurable delay
- **[lsp_lines.nvim](https://git.sr.ht/~whynothugo/lsp_lines.nvim)** - VSCode ErrorLens-style diagnostics with inline error messages and full-line highlighting

## Keybinds

**Leader Key:** `Space`

### File Explorer (Neo-tree)
- `<leader>fe` - Toggle file explorer
- `<leader>e` - Open file explorer

### Fuzzy Finder (Telescope)
- `<leader>ff` - Find files
- `<leader>fg` - Live grep (search in files)
- `<leader>fb` - Browse open buffers
- `<leader>fh` - Search help tags

### LSP (Language Server)
*Available when in a file with LSP support (e.g., PHP files)*
- `gd` - Go to definition
- `K` - Show hover documentation
- `gi` - Go to implementation
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code actions

### Autocompletion
*Available in insert mode*
- `<C-Space>` - Trigger completion menu
- `<CR>` (Enter) - Confirm selection
- `<Tab>` - Select next item / expand snippet
- `<S-Tab>` (Shift+Tab) - Select previous item / jump back in snippet

### Quick Actions
- `<leader>w` - Save file
- `<leader>q` - Quit

## Additional Configuration

- **Line numbers:** Enabled with relative line numbers
- **System clipboard:** Integrated with system clipboard for seamless copy/paste
- **True colors:** Enabled for better color accuracy in supported terminals
- **Autosave:** Files automatically save 1 second after changes (on InsertLeave and TextChanged events)

### To be added
- [ ] Autosuggest like Copilot in VSCode  
- [ ] AI Chat
- [ ] Sync colorscheme with wallust, while keeping the texts color from tokyonight colorscheme
