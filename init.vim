" Set space as leader key
let mapleader = " "

" General settings
set clipboard+=unnamed
set ignorecase
set incsearch
set number
set relativenumber
set scrolloff=5
set showmode
set smartcase
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
set timeoutlen=500

" VSCode-like settings
set cursorline
set expandtab
set shiftwidth=4
set tabstop=4
set nowrap
set colorcolumn=88,120
set list
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»

" Key mappings
" Move to beginning/end of line
nnoremap H ^
nnoremap L $

" Move selected lines up/down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Redo
nnoremap U <C-R>

" Quick edit and reload of init.vim
nnoremap <leader>ve :e ~/.config/nvim/init.vim<CR>
nnoremap <leader>vr :source ~/.config/nvim/init.vim<CR>

" Better escape
inoremap jk <Esc>

" Replace entire buffer with system clipboard contents
nnoremap <leader>sp ggVG"+p

" Preserve some Vim functionalities
nnoremap % %
nnoremap # #
nnoremap g; g;
nnoremap g, g,
nnoremap <C-u> <C-u>
nnoremap <C-d> <C-d>

" Tabs and buffers
nnoremap <leader>] :bnext<CR>
nnoremap <leader>[ :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>

" Windows and splits
nnoremap <leader>sv :vsplit<CR>
nnoremap <leader>sh :split<CR>
nnoremap <leader>sc :close<CR>

" Move between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>x :x<CR>

" Folding
nnoremap <leader>fc :fold<CR>
nnoremap <leader>fo :foldopen<CR>
nnoremap <leader>fC :foldclose<CR>
nnoremap <leader>fO :foldopen!<CR>
nnoremap <leader>fa :foldclose!<CR>

" Marks
nnoremap <leader>m :mark<Space>
nnoremap <leader>' :marks<CR>

" Quick window switching
nnoremap <leader>w <C-w>w

" Commentary (requires commentary.vim plugin)
nnoremap <leader>/ :Commentary<CR>

" VSCode-like keybindings
nnoremap <leader>e :Lexplore<CR>
nnoremap <leader>f :find<Space>
nnoremap <leader>g :grep<Space>
nnoremap <leader>h :noh<CR>
nnoremap <C-p> :Files<CR>
nnoremap <leader>t :terminal<CR>

" Plugins (using vim-plug)
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()

" Color scheme
colorscheme dracula

" Reminder comments
" zf - create fold
" zo - open fold
" zc - close fold
" zR - open all folds
" zM - close all folds
" m{a-zA-Z} - set mark
" '{a-zA-Z} - jump to mark
" q{a-z} - record macro
" @{a-z} - play macro
" @@ - replay last macro
