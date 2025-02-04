# Daily Vim Practice Routine

## Quick Reference - Most Used Commands

### Navigation Mode
- `H` - Previous buffer
- `L` - Next buffer
- `E` - End of line
- `B` - Beginning of line
- `<space>w` - Save file
- `<space>x` - Close active editor
- `<space>tt` - Toggle terminal
- `<space>e` - Toggle explorer

### Space Leader Commands (From keybindings.json)
- `<space>sf` - Find in files
- `<space>ss` - Go to symbol
- `<space>sv` - Split editor vertically
- `<space>sh` - Split editor horizontally
- `<space>tm` - Toggle maximized panel
- `<space>h` - Clear search highlighting

## Daily Practice Exercises

### 1. Vim-Surround Practice
```text
Practice text: hello world example text
Tasks:
1. ysiw" -> "hello" world example text
2. ysiw) -> "hello" (world) example text
3. ysiw} -> "hello" (world) {example} text
4. ys$" -> "hello" (world) {example} "text"
5. cs"' -> 'hello' (world) {example} "text"
6. cs({ -> { hello } (world) {example} "text"
7. ds" -> hello (world) {example} "text"
8. dst -> hello (world) example text
```

### 2. Macro Practice
```text
Practice lines:
- [ ] Task 1
- [ ] Task 2
- [ ] Task 3
- [ ] Important task
- [ ] Critical task

Macro Exercises:
1. Record macro 'q' to add 'DONE: ' at start of line
   - qq
   - I
   - DONE:
   - <Esc>
   - q
2. Record macro 'w' to mark task as done
   - qw
   - f]
   - i x<Esc>
   - q
3. Apply macro to multiple lines
   - 5@q
   - 5@w
```

### 3. Marks Practice
```text
Practice using marks:
1. Set marks:
   - ma - Set mark 'a' at current position
   - mA - Set global mark 'A'
   - mb - Set mark 'b' at another position

2. Jump to marks:
   - 'a - Jump to line of mark a
   - `a - Jump to exact position of mark a
   - 'A - Jump to global mark A

Common mark letters to use:
- a - For temporary position A
- b - For temporary position B
- m - For middle of current work
- t - For top of current work
- e - For end of current work
```

### 4. Terminal Integration Practice
```
Workflow exercises:
1. Edit -> Terminal -> Edit:
   - <space>tt (toggle terminal)
   - Run git status
   - <C-\> (exit terminal mode)
   - <C-w>k (move to editor)

2. Split Terminal Workflow:
   - <space>sv (split vertically)
   - <space>tt (open terminal)
   - Practice moving between splits
```

### 5. Search and Replace Practice
```
Using grep (from aliases):
1. Using ripgrep (alias grep='rg'):
   - grep "pattern" .
   - grep -i "case insensitive"
   - grep -l "list files only"

Using Telescope:
1. File search:
   - <space>ff (find files)
   - Type partial filename
   - Navigate results with <C-j>/<C-k>

2. Text search:
   - <space>fg (live grep)
   - Type search pattern
   - Preview results
```

### 6. Common Workflows to Practice

#### Git Workflow
1. Check status: `<space>tt` -> `gs` or `git status`
2. View changes: `<space>tt` -> `gd` or `git diff`
3. Stage changes: `<space>tt` -> `ga .`
4. Commit: `<space>tt` -> `gcm "message"`
5. Push: `<space>tt` -> `gp`

#### File Navigation Workflow
1. Open explorer: `<space>e`
2. Find file: `<space>ff`
3. Search in files: `<space>fg`
4. Navigate buffers: `H` and `L`
5. Close others: `<space>qo`

#### Code Navigation Workflow
1. Go to definition: `<space>gd`
2. Find references: `<space>gr`
3. Show hover: `<space>k`
4. Quick fix: `<space>;`
5. Format document: `<space>=`

## Daily Practice Routine

1. Start with basic movements (10 minutes):
   - Practice `H`, `L`, `E`, `B`
   - Navigate between splits
   - Use marks to jump between positions

2. Text manipulation (10 minutes):
   - Practice vim-surround commands
   - Record and apply macros
   - Practice common edit operations

3. Search and navigation (10 minutes):
   - Practice Telescope commands
   - Use grep for searching
   - Navigate between files and symbols

4. Terminal integration (5 minutes):
   - Practice terminal toggles
   - Run git commands
   - Switch between editor and terminal

5. Custom workflow practice (10 minutes):
   - Pick one workflow from above
   - Practice it end-to-end
   - Try to optimize your movements

## Tips for Practice
- Focus on one category per day
- Try to use keyboard shortcuts instead of mouse
- Keep track of commands you find difficult
- Add new commands to practice as you learn them
- Time yourself on common operations
- Try to reduce keystrokes for common tasks

## Commands to Master Next
- [ ] Practice visual block mode (Ctrl+v)
- [ ] Learn more about text objects (iw, aw, ip, ap)
- [ ] Master window management commands
- [ ] Explore more Telescope features
- [ ] Practice LSP integration commands

Remember: The goal is not speed but building muscle memory. Practice deliberately and regularly.
