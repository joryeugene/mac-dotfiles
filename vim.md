# Vim Quick Reference

## Essential Plugins

### vim-surround
```
# Adding surroundings
ys{motion}{char}   " Add surrounding
ysiw"              " Surround word with quotes: hello -> "hello"
yss"               " Surround entire line with quotes
ys$"               " Surround to end of line with quotes
yS{motion}{char}   " Add surrounding and place on new line

# Changing surroundings
cs{old}{new}       " Change surrounding
cs"'               " Change quotes: "hello" -> 'hello'
cs'<q>             " Change quotes to tag: 'hello' -> <q>hello</q>
cst"               " Change tag to quotes: <q>hello</q> -> "hello"

# Deleting surroundings
ds{char}           " Delete surrounding
ds"                " Delete quotes: "hello" -> hello
dst                " Delete tag: <q>hello</q> -> hello

# In Visual Mode
S{char}            " Surround selection
```

### vim-commentary
```
gcc                " Comment/uncomment current line
gc{motion}         " Comment/uncomment selection
gcap               " Comment/uncomment paragraph
gcG                " Comment/uncomment to end of file
:g/TODO/Commentary " Comment all lines matching pattern
```

### vim-repeat
```
.                  " Repeat last change (works with surround/commentary)
```

## Space Leader Keybindings

### File Operations
```
<space>w          " Save file
<space>x          " Close active editor
<space>qa         " Close all editors
<space>qo         " Close other editors
<space>n          " New untitled file
<space>o          " Quick open file
<space>f          " Open recent files
```

### Navigation
```
<space>gd         " Go to definition
<space>gi         " Go to implementation
<space>gr         " Go to references
<space>gs         " Show all symbols
<space>gg         " Go to line
<space>gl         " Go to line
<space>-          " Navigate back
<space>[          " Previous error/warning
<space>]          " Next error/warning
<space>1-9        " Go to editor tab 1-9
```

### Editor Features
```
<space>/          " Toggle line comment
<space>'          " Format selection
<space>;          " Quick fix
<space>=          " Format document
<space>a          " Select all (ggVG)
<space>b          " Toggle breakpoint
<space>c          " Change inner word
<space>h          " Clear search highlighting
<space>k          " Show hover
<space>u          " Convert to uppercase
```

### View Management
```
<space>e          " Toggle explorer
<space>p          " Show problems
<space>sv         " Split editor vertically
<space>sh         " Split editor horizontally
<space>z          " Toggle zen mode
<space>\\         " Toggle statusbar
```

### Terminal
```
<space>tt         " Toggle terminal
<space>tm         " Toggle maximized panel
<space>tn         " New terminal
<space>tk         " Kill terminal
```

### Search and Replace
```
<space>sf         " Find in files
<space>ss         " Go to symbol
```

### Configuration
```
<space>yg         " Open global keybindings
<space>ys         " Open settings.json
<space>yk         " Open keybindings.json
<space>yy         " Open global settings
<space>yr         " Reload window
<space>yv         " Open Neovim config
<space>yz         " Open Zsh config
```

### AI and Intellisense
```
<space>ie         " Trigger inline suggestion
<space>ic         " New composer action
<space>if         " Fix error message
<space>in         " New chat action
```

## File Operations
:echo @%           " show current file (relative path)
:echo expand('%:p') " show absolute file path
:e filename        " edit a file
:wq                " save and quit
:q!                " quit without saving

## Visual Mode
v               " Enter character-wise visual mode
V               " Enter line-wise visual mode
Ctrl+v          " Enter block visual mode
y               " Yank (copy) selected text
d               " Delete selected text

## Search & Replace
/pattern        " Search forward for pattern
?pattern        " Search backward for pattern
n               " Repeat search in the same direction
N               " Repeat search in the opposite direction
*               " Search forward for word under cursor
#               " Search backward for word under cursor
:%s/old/new/g   " Replace all occurrences in the file
:%s/old/new/gc  " Replace with confirmation
:noh            " Clear search highlighting

## Windows and Tabs
:sp             " Horizontal split (open file in new split)
:vsp            " Vertical split
Ctrl+w h/j/k/l  " Navigate between splits
:tabnew         " Open a new tab
gt              " Move to next tab
gT              " Move to previous tab

## Marks and Jumping
ma              " Set mark 'a' at current cursor position
`a              " Jump to mark 'a' (exact position)
'a              " Jump to the beginning of the line of mark 'a'
:marks          " List all marks

## Macros
qa ... q      " Record macro into register 'a'
@a             " Replay macro from register 'a'
@@             " Replay the last executed macro

## Registers
"ay             " Yank into register a
"ap             " Paste content from register a
:registers      " Show all registers

## Other Useful Commands
:f               " Display file info (name, file type, etc.)
:pwd             " Display working directory
:ls              " List open buffers
:!date           " Execute external command (e.g., show current date)

## Advanced Editing
ciw             " Change inner word
caw             " Change a word (including surrounding spaces)
di(             " Delete text inside parentheses
da(             " Delete text including the parentheses
~               " Toggle case of character under cursor
.               " Repeat last change
gd              " Go to definition
gD              " Go to declaration
K               " Show documentation
<C-o>           " Jump back
<C-i>           " Jump forward
zz              " Center cursor on screen
zt              " Put cursor at top of screen
zb              " Put cursor at bottom of screen

## Additional Workflows
- Use buffer commands like `:bnext` and `:bprev` to navigate between open files.
- Leverage window splits to compare files side by side.
- Practice using macros to automate repetitive editing tasks.

## Inserting Information into the Buffer
:put =expand('%:p')  " Insert the absolute path of the current file into the buffer
:put =@%              " Insert the relative path of the current file into the buffer
