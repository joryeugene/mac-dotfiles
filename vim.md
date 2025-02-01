# Vim Quick Reference

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

## Pro Tips
- Use counts with commands (e.g., `5dd` deletes 5 lines).
- Combine operators with motions (e.g., `d2w` deletes two words).
- Utilize registers for multiple copy/paste operations.
- Drill these commands regularly to build muscle memory.
- Use `:help {command}` for details on any Vim command.

## Additional Workflows
- Use buffer commands like `:bnext` and `:bprev` to navigate between open files.
- Leverage window splits to compare files side by side.
- Practice using macros to automate repetitive editing tasks.

## Inserting Information into the Buffer
:put =expand('%:p')  " Insert the absolute path of the current file into the buffer
:put =@%              " Insert the relative path of the current file into the buffer
