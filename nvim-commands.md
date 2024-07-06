# Neovim Command Cheat Sheet

## General Commands

- `:w` - Save file
- `:q` - Quit
- `:wq` or `:x` - Save and quit
- `:q!` - Quit without saving
- `:e <filename>` - Open file
- `:bn` - Next buffer
- `:bp` - Previous buffer
- `:bd` - Close buffer
- `:sp` - Horizontal split
- `:vsp` - Vertical split
- `:enew` - Open a new blank buffer
- `:tabnew` - Open a new blank buffer in a new tab

## Navigation

- `h`, `j`, `k`, `l` - Move left, down, up, right
- `w` - Move to next word
- `b` - Move to previous word
- `0` - Move to start of line
- `$` - Move to end of line
- `gg` - Go to first line
- `G` - Go to last line
- `<C-u>` - Scroll up half a page
- `<C-d>` - Scroll down half a page
- `<C-o>` - Jump to previous location
- `<C-i>` - Jump to next location

## Editing

- `i` - Insert mode
- `a` - Append
- `o` - Open new line below
- `O` - Open new line above
- `x` - Delete character
- `dd` - Delete line
- `yy` - Yank (copy) line
- `p` - Paste after cursor
- `P` - Paste before cursor
- `u` - Undo
- `<C-r>` - Redo

## Visual Mode

- `v` - Enter visual mode
- `V` - Enter visual line mode
- `<C-v>` - Enter visual block mode

## Search and Replace

- `/pattern` - Search forward
- `?pattern` - Search backward
- `n` - Next search result
- `N` - Previous search result
- `:%s/old/new/g` - Replace all occurrences in file

## Plugin-Specific Commands

### NERDTree

- `<C-n>` - Toggle NERDTree
- `o` - Open file/directory
- `t` - Open in new tab
- `i` - Open split
- `s` - Open vsplit

### FZF

- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Buffers
- `<leader>fh` - Help tags

### EasyMotion

- `<leader>w` - Word motions
- `<leader>f{char}` - Find character
- `<leader>s{char}` - Search for character
- `<leader>s2{char}` - 2-character search

### Commentary

- `gcc` - Comment/uncomment line
- `gc` - Comment/uncomment selection (in visual mode)

### Fugitive

- `:Git` or `:G` - Git status
- `:Git commit` - Git commit
- `:Git push` - Git push
- `:Git pull` - Git pull
- `:Gblame` - Git blame

### CoC (Conquer of Completion)

- `gd` - Go to definition
- `gy` - Go to type definition
- `gi` - Go to implementation
- `gr` - Go to references
- `K` - Show documentation
- `<leader>rn` - Rename
- `<leader>f` - Format selected code

### Telescope

- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Buffers
- `<leader>fh` - Help tags

### Iron.nvim (REPL)

- `<leader>sl` - Send line to REPL
- `<leader>sc` - Send visual selection to REPL
- `<leader>sf` - Send file to REPL
- `<leader>su` - Send until cursor to REPL
- `<leader>sm` - Send mark to REPL
- `<leader>mc` - Mark motion
- `<leader>md` - Remove mark
- `<leader>s<cr>` - Send CR to REPL
- `<leader>s<space>` - Interrupt REPL
- `<leader>sq` - Exit REPL
- `<leader>cl` - Clear REPL

### Surround

- `ys{motion}{char}` - Surround motion with char
- `cs{old}{new}` - Change surrounding old with new
- `ds{char}` - Delete surrounding char

## Terminal Commands

### Using Neovim's Built-in Terminal

- `:terminal` - Open terminal
- `<C-\><C-n>` - Exit terminal mode
- `<C-w>h`, `<C-w>j`, `<C-w>k`, `<C-w>l` - Navigate between splits
- `tnoremap <C-h> <C-\><C-n><C-w>h` - Map to navigate left from terminal
- `tnoremap <C-j> <C-\><C-n><C-w>j` - Map to navigate down from terminal
- `tnoremap <C-k> <C-\><C-n><C-w>k` - Map to navigate up from terminal
- `tnoremap <C-l> <C-\><C-n><C-w>l` - Map to navigate right from terminal

## Common Workflow Examples

### Opening and Navigating Files

1. Open NERDTree: `<C-n>`
2. Navigate to file: `j`, `k`
3. Open file: `o`
4. Switch between windows: `<C-w>h`, `<C-w>j`, `<C-w>k`, `<C-w>l`

### Searching for Files and Content

1. Open Telescope file finder: `<leader>ff`
2. Type file name and use `<C-j>` and `<C-k>` to navigate results
3. Press `<CR>` to open selected file
4. Search for content: `<leader>fg`, type search term

### Editing and Moving Code

1. Enter insert mode: `i`
2. Exit insert mode: `<Esc>`
3. Copy line: `yy`
4. Paste line: `p`
5. Move line up/down: `ddkP` or `ddp`
6. Comment/uncomment line: `gcc`

### Git Operations

1. Open Git status: `:G`
2. Stage changes: `s` on each file in Git status window
3. Commit changes: `:G commit`
4. Push changes: `:G push`

### Code Navigation and Refactoring

1. Go to definition: `gd`
2. Find references: `gr`
3. Rename symbol: `<leader>rn`
4. Format code: `<leader>f`

### Working with Multiple Files

1. Open new buffer: `:enew`
2. List buffers: `:ls`
3. Switch to next/previous buffer: `:bn`, `:bp`
4. Close current buffer: `:bd`

### Using REPL for Interactive Development

1. Open Python REPL: `:IronRepl`
2. Send current line to REPL: `<leader>sl`
3. Clear REPL: `<leader>cl`

### Quick Navigation Within File

1. Jump to word: `<leader>w` followed by highlighted letter (EasyMotion)
2. Search for character: `<leader>f{char}`

### Splitting Windows

1. Create horizontal split: `:sp`
2. Create vertical split: `:vsp`
3. Navigate between splits: `<C-w>h`, `<C-w>j`, `<C-w>k`, `<C-w>l`
4. Resize splits: `<C-w>+`, `<C-w>-`, `<C-w>>`, `<C-w><`

### Text Objects and Surround

1. Change inside parentheses: `ci(`
2. Change around quotes: `ca"`
3. Surround word with quotes: `ysiw"`
4. Delete surrounding tags: `dst`

### Terminal Commands

1. Open terminal: `:terminal`
2. Exit terminal mode: `<C-\><C-n>`
3. Navigate between splits: `<C-w>h`, `<C-w>j`, `<C-w>k`, `<C-w>l`
4. Run a command: Type the command and press `<CR>`
5. Switch focus between terminal and editor: `<C-w>h`, `<C-w>j`, `<C-w>k`, `<C-w>l`

## Full-Stack Web Development Workflow

### Backend Development (Python, FastAPI, SQLModel)

1. Open NERDTree: `<C-n>`
2. Navigate to backend directory: `j`, `k`
3. Open main FastAPI file: `o`
4. Edit code: `i` to insert, `<Esc>` to exit insert mode
5. Run server: `:terminal` and type `uvicorn main:app --reload`
6. Switch back to editor: `<C-\><C-n>`, `<C-w>h`
7. Navigate to test file: `<leader>ff`, type test file name, `<CR>`
8. Run tests: `:terminal` and type `pytest`

### Frontend Development (React or SvelteKit)

1. Open NERDTree: `<C-n>`
2. Navigate to frontend directory: `j`, `k`
3. Open main component file: `o`
4. Edit code: `i` to insert, `<Esc>` to exit insert mode
5. Run development server: `:terminal` and type `npm start`
6. Switch back to editor: `<C-\><C-n>`, `<C-w>h`
7. Navigate to another component file: `<leader>ff`, type component file name, `<CR>`
8. Edit and save changes: `i` to insert, `<Esc>` to exit insert mode, `:w`

### Database Management (PostgreSQL)

1. Open terminal: `:terminal`
2. Connect to PostgreSQL: Type `psql -h <host> -U <user> -d <database>`
3. Run SQL queries: Type SQL commands and press `<CR>`
4. Switch back to editor: `<C-\><C-n>`, `<C-w>h`

### Cloud Management (AWS)

1. Open terminal: `:terminal`
2. Run AWS CLI commands: Type commands like `aws s3 ls`, `aws ec2 describe-instances`
3. Switch back to editor: `<C-\><C-n>`, `<C-w>h`

### General Tips

- Use EasyMotion for quick navigation within files.
- Use Telescope for fuzzy finding files and content.
- Use GitGutter and Fugitive for Git integration.
- Use Iron.nvim for interactive development with REPLs.
- Use Surround for easy manipulation of surrounding characters.
- Use NERDTree for file navigation.
- Use CoC for code completion and navigation.
