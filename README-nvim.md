# Neovim Configuration

This is a comprehensive Neovim configuration designed for efficient coding and text editing, particularly tailored for full-stack web development. It includes various plugins and custom keybindings to enhance productivity.

## Features

- Modern UI with Dracula theme and lualine status bar
- File navigation with nvim-tree and Telescope
- Git integration with Fugitive and Gitsigns
- Code completion and LSP support with built-in LSP and nvim-cmp
- Markdown preview
- Easy motion for quick navigation
- Terminal integration with toggleterm
- Text object manipulation with vim-surround
- Syntax highlighting with Treesitter
- And much more!

## Prerequisites

- Neovim (0.5 or later recommended)
- Git
- Node.js (for some LSP servers)
- Python 3 (for some plugins)
- A Nerd Font (for icons)
- Ripgrep (for Telescope live grep)
- fd (optional but recommended for Telescope)

### Installing Prerequisites on macOS

1. **Install Homebrew** (if not already installed):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Install Neovim**:
   ```bash
   brew install neovim
   ```

3. **Install other dependencies**:
   ```bash
   brew install git node python3 ripgrep fd
   ```

4. **Install a Nerd Font**:
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
   ```bash
   git clone https://github.com/yourusername/neovim-config.git ~/.config/nvim
   ```

3. **Install vim-plug** (the plugin manager):
   ```bash
   sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
   ```

4. **Open Neovim and run `:PlugInstall` to install the plugins**.

5. **Install language servers** for the languages you use (e.g., pyright for Python, tsserver for JavaScript/TypeScript).

## Key Mappings

Here are some of the most important key mappings:

- `<Space>` is the leader key
- `<leader>n` Toggle nvim-tree
- `<leader>ff` Search files with Telescope
- `<leader>fg` Live grep with Telescope
- `<leader>/` Comment/uncomment lines
- `gd` Go to definition (LSP)
- `gr` Find references (LSP)
- `K` Show documentation (LSP)
- `<C-j/k/h/l>` Navigate between splits
- `<leader>vs` Create vertical split
- `<leader>ns` Create horizontal split
- `<leader>w` EasyMotion word motion
- `<C-\>` Toggle terminal

## Workflow Examples

### Backend Development (Python, FastAPI, SQLModel)

1. Open nvim-tree: `<leader>n`
2. Navigate to backend directory: `j`, `k`
3. Open main FastAPI file: `<CR>`
4. Edit code: `i` to insert, `<Esc>` to exit insert mode
5. Open terminal: `<C-\>`
6. Run server: Type `uvicorn main:app --reload`
7. Switch back to editor: `<C-\>` (toggle terminal)
8. Navigate to test file: `<leader>ff`, type test file name, `<CR>`
9. Run tests: Open terminal `<C-\>` and type `pytest`

### Frontend Development (React or SvelteKit)

1. Open nvim-tree: `<leader>n`
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

