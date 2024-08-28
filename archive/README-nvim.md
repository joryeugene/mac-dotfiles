# Neovim Configuration

This is a comprehensive Neovim configuration designed for efficient coding and text editing, particularly tailored for full-stack web development. It includes various plugins and custom keybindings to enhance productivity and align closely with PyCharm's IdeaVim setup.

## Features

- Modern UI with Dracula theme and lualine status bar
- File navigation with nvim-tree and Telescope
- Git integration with Fugitive and Gitsigns
- Code completion and LSP support with built-in LSP and nvim-cmp
- Markdown preview
- EasyMotion for quick navigation
- Terminal integration with toggleterm
- Syntax highlighting with Treesitter
- Which-key for discovering key bindings
- And much more!

## Prerequisites

- Neovim (0.5 or later recommended)
- Git
- Node.js and npm (for language servers and some plugins)
- Python 3 (for some plugins)
- A Nerd Font (for icons)
- Ripgrep (for Telescope live grep)
- fd (optional but recommended for Telescope)

## Key Mappings

Here are some of the most important key mappings:

### General

- `<Space>` is the leader key
- `jk` - Escape (in insert mode)
- `U` - Redo

### File Operations

- `<leader>w` - Save file
- `<leader>ve` - Edit Neovim config
- `<leader>vr` - Reload Neovim config

### Navigation

- `H` - Move to beginning of line
- `L` - Move to end of line
- `<C-h/j/k/l>` - Navigate between splits

### Window Management

- `<leader>sv` - Split vertically
- `<leader>sh` - Split horizontally
- `<leader>sc` - Close split
- `<leader>me` - Maximize current split
- `<leader>=` - Equalize splits

### Buffer Navigation

- `<leader>]` - Next buffer
- `<leader>[` - Previous buffer
- `<leader>b` - List buffers (Telescope)

### Close Windows and Buffers

- `<leader>qx` - Close window
- `<leader>qa` - Close all windows
- `<leader>qo` - Close other buffers
- `<leader>qt` - Close tab

### Search and Replace

- `<leader>se` - Search everything (Telescope)
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fp` - Find in path

### Code Navigation and Editing

- `<leader>gc` - Git commits
- `<leader>gf` - Git files
- `<leader>a` - Actions menu
- `<leader>rl` - Recent files
- `<leader>rr` - Find files
- `<leader>nd` - New directory
- `<leader>ro` - Reopen last closed buffer
- `<leader>sw` - Toggle soft wrap

### LSP

- `gd` - Go to definition
- `gr` - Go to references
- `gi` - Go to implementation
- `K` - Show documentation
- `<leader>rf` - Find references
- `<leader>i` - Code actions
- `<leader>qi` - Quick implementation
- `<leader>su` - Show usages
- `<leader>oi` - Organize imports
- `<leader>pi` - Parameter info
- `<leader>sd` - Show diagnostics

### Git

- `<leader>gs` - Git status
- `<leader>gc` - Git commit
- `<leader>gp` - Git push
- `<leader>gl` - Git pull

### NvimTree

- `<leader>pt` / `<leader>tp` - Toggle file tree

### Commentary

- `<leader>/` - Comment/uncomment

### Terminal

- `<leader>tt` - Toggle terminal

### Markdown Preview

- `<leader>mp` - Start Markdown preview
- `<leader>ms` - Stop Markdown preview

## Plugin List

- vim-commentary
- vim-easymotion
- nvim-tree.lua
- lualine.nvim
- vim-fugitive
- gitsigns.nvim
- dracula/vim
- markdown-preview.nvim
- telescope.nvim
- nvim-treesitter
- nvim-lspconfig
- nvim-cmp (with various sources)
- which-key.nvim
- toggleterm.nvim
- indent-blankline.nvim
- vim-surround

## Customization

To customize this configuration, edit the `init.vim` file in your Neovim config directory. You can add new plugins, change keybindings, or modify existing settings to suit your preferences.

## Troubleshooting

If you encounter any issues:

1. Make sure all prerequisites are installed
2. Run `:checkhealth` in Neovim for diagnostics
3. Ensure all plugins are up to date with `:PlugUpdate`
4. Check the Neovim and plugin documentation for any recent changes
5. For LSP issues, use `:LspInfo` to check the status of language servers
