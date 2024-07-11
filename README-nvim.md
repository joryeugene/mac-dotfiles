# Neovim Configuration

This is a comprehensive Neovim configuration designed for efficient coding and text editing, particularly tailored for full-stack web development. It includes various plugins and custom keybindings to enhance productivity and align closely with PyCharm's IdeaVim setup.

## Features

- Modern UI with Dracula theme and lualine status bar
- File navigation with nvim-tree and Telescope
- Git integration with Fugitive and Gitsigns
- Code completion and LSP support with built-in LSP and nvim-cmp
- Markdown preview
- EasyMotion for quick navigation (similar to AceJump in PyCharm)
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

### Installing Prerequisites on macOS

1. **Install Homebrew** (if not already installed):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Install Neovim and dependencies**:
   ```bash
   brew install neovim git node python3 ripgrep fd
   ```

3. **Install a Nerd Font**:
   ```bash
   brew tap homebrew/cask-fonts
   brew install --cask font-hack-nerd-font
   ```

## Installation

1. **Backup your existing Neovim configuration** (if you have one):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this repository**:

3. **Install vim-plug** (the plugin manager):
   ```bash
   sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
   ```

4. **Open Neovim and run `:PlugInstall` to install the plugins**.

## Language Server Setup

To enable advanced language features like auto-completion, go-to-definition, and more, you need to install and configure language servers:

1. **Install language servers using npm**:
   ```bash
   npm install -g pyright typescript typescript-language-server bash-language-server vscode-langservers-extracted
   ```

2. **Install Marksman for Markdown support** (on macOS):
   ```bash
   brew install marksman
   ```
   For other operating systems, refer to the [Marksman GitHub page](https://github.com/artempyanykh/marksman).

3. **Configure language servers in Neovim**:
   Add the following Lua code to your `init.vim` (inside a Lua heredoc) or `init.lua`:

   ```lua
   local nvim_lsp = require('lspconfig')

   -- Configure language servers
   nvim_lsp.pyright.setup{}
   nvim_lsp.tsserver.setup{}
   nvim_lsp.bashls.setup{}
   nvim_lsp.html.setup{}
   nvim_lsp.cssls.setup{}
   nvim_lsp.jsonls.setup{}
   nvim_lsp.marksman.setup{}

   -- Global mappings for LSP functionality
   vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
   vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
   vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
   vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

   -- Additional LSP configuration...
   ```

   Refer to the full configuration file for complete LSP setup.

## Key Mappings

Here are some of the most important key mappings:

### Navigation

- `<Space>` is the leader key
- `<leader>e` - EasyMotion (find character)
- `<leader>w` - EasyMotion (word motion)
- `<C-o>` - Navigate back
- `<C-i>` - Navigate forward
- `H` - Move to beginning of line
- `L` - Move to end of line

### File and Project Management

- `<leader>n` - Toggle nvim-tree
- `<leader>ff` - Find files with Telescope
- `<leader>fg` - Live grep with Telescope
- `<leader>fb` - Browse buffers
- `<leader>p` - Toggle project view (nvim-tree)

### Editing and Code Navigation

- `<leader>/` - Comment/uncomment lines
- `gd` - Go to definition (LSP)
- `gr` - Find references (LSP)
- `gi` - Go to implementation (LSP)
- `K` - Show documentation (LSP)
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code action
- `<leader>rf` - Refactoring menu (Telescope LSP)

### Windows and Tabs

- `<leader>sv` - Create vertical split
- `<leader>sh` - Create horizontal split
- `<C-h/j/k/l>` - Navigate between splits
- `<leader>q` - Close current buffer
- `<leader>qa` - Close all buffers
- `<leader>qo` - Close other buffers

### Other

- `<C-\>` - Toggle terminal
- `<leader>z` - Toggle distraction-free mode
- `<leader>se` - Search everywhere (Telescope)
- `<leader>a` - Find action (Telescope commands)
- `<leader>r` - Recent files
- `<leader>fp` - Find in path
- `<leader>i` - Show intention actions
- `<leader>sw` - Toggle soft wrap

## Workflow Examples

### Backend Development (Python, FastAPI, SQLModel)

1. Open project view: `<leader>p`
2. Navigate to backend directory: `j`, `k`
3. Open main FastAPI file: `<CR>`
4. Edit code: `i` to insert, `<Esc>` to exit insert mode
5. Open terminal: `<C-\>`
6. Run server: Type `uvicorn main:app --reload`
7. Switch back to editor: `<C-\>` (toggle terminal)
8. Navigate to test file: `<leader>ff`, type test file name, `<CR>`
9. Run tests: Open terminal `<C-\>` and type `pytest`

### Frontend Development (React or SvelteKit)

1. Open project view: `<leader>p`
2. Navigate to frontend directory: `j`, `k`
3. Open main component file: `<CR>`
4. Edit code: `i` to insert, `<Esc>` to exit insert mode
5. Open terminal: `<C-\>`
6. Run development server: Type `npm start`
7. Switch back to editor: `<C-\>` (toggle terminal)
8. Navigate to another component file: `<leader>ff`, type component file name, `<CR>`
9. Edit and save changes: `i` to insert, `<Esc>` to exit insert mode, `:w`

## Plugin-Specific Commands

### nvim-tree

- `<leader>n` - Toggle nvim-tree
- `<CR>` - Open file/directory
- `a` - Create new file/directory
- `r` - Rename file/directory
- `d` - Delete file/directory
- `c` - Copy file/directory
- `x` - Cut file/directory
- `p` - Paste file/directory

### Telescope

- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Buffers
- `<leader>fh` - Help tags

### EasyMotion

- `<leader>w` - Word motions
- `<leader>f{char}` - Find character

### Commentary

- `gcc` - Comment/uncomment line
- `gc` - Comment/uncomment selection (in visual mode)

### Fugitive

- `:Git` or `:G` - Git status
- `:Git commit` - Git commit
- `:Git push` - Git push
- `:Git pull` - Git pull

### LSP

- `gd` - Go to definition
- `gr` - Go to references
- `gi` - Go to implementation
- `K` - Show documentation
- `<leader>rn` - Rename
- `<leader>ca` - Code action

### Toggleterm

- `<C-\>` - Toggle terminal

## Troubleshooting

If you encounter any issues:

1. Make sure all prerequisites are installed
2. Run `:checkhealth` in Neovim for diagnostics
3. Ensure all plugins are up to date with `:PlugUpdate`
4. Check the Neovim and plugin documentation for any recent changes
5. For LSP issues, use `:LspInfo` to check the status of language servers

