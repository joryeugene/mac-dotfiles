" OBSIDIAN VIMRC (.obsidian.vimrc) for calmhive

" Yank to system clipboard
set clipboard=unnamed

" Tab navigation
exmap nextTab obcommand workspace:previous-tab
nmap H :nextTab
exmap prevTab obcommand workspace:next-tab
nmap L :prevTab

" Quick note creation
exmap newNote obcommand file-explorer:new-file
nmap <C-n> :newNote

" Toggle sidebar
exmap toggleLeftSidebar obcommand app:toggle-left-sidebar
nmap <C-b> :toggleLeftSidebar

" Search in all files
exmap searchAllFiles obcommand search:open
nmap <C-f> :searchAllFiles

" EXAMPLE: Go back and forward with Ctrl+O and Ctrl+I
" (make sure to remove default Obsidian shortcuts for these to work)
exmap back obcommand app:go-back
nmap <C-o> :back
exmap forward obcommand app:go-forward
nmap <C-i> :forward
