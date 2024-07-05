" Set leader key
let mapleader = " "

" General settings
set scrolloff=5
set incsearch
set showmode
set number
set relativenumber
set clipboard+=unnamed
set splitbelow
set splitright
set ignorecase
set smartcase
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Don't use Ex mode, use Q for formatting
map Q gq

" Install vim-plug if not found
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.local/share/nvim/plugged')

" Plugins
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

call plug#end()

" Plugin settings
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Dracula theme
colorscheme dracula

" Airline settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Key mappings
" Commentary
noremap <leader>/ :Commentary<CR>

" Toggle Markdown Preview
nnoremap <leader>mp :MarkdownPreview<CR>
nnoremap <leader>ms :MarkdownPreviewStop<CR>

" EasyMotion
map <leader>w <Plug>(easymotion-bd-w)

" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>

" FZF
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :GFiles<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fl :Lines<CR>

" CoC mappings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>qf <Plug>(coc-fix-current)
nnoremap <silent> K :call CocAction('doHover')<CR>

" Navigation
nnoremap <C-o> <C-o>
nnoremap <C-i> <C-i>

" Move to beginning/end of line
nnoremap H ^
nnoremap L $

" Move selected lines up/down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Redo
nnoremap U <C-R>

" Quick edit and reload of init.vim
nnoremap <leader>vv :e $MYVIMRC<CR>
nnoremap <leader>vr :source $MYVIMRC<CR>

" Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Split creation
nnoremap <leader>vs :vsplit<CR>
nnoremap <leader>ns :split<CR>

" Buffer navigation
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bf :bfirst<CR>
nnoremap <leader>bl :blast<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <leader>ls :ls<CR>

" Resize splits
nnoremap <silent> <leader>+ :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>
nnoremap <silent> <leader>> :resize +5<CR>
nnoremap <silent> <leader>< :resize -5<CR>

" Fugitive mappings
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gl :Git pull<CR>

" GitGutter mappings
nnoremap <leader>hp :GitGutterPreviewHunk<CR>
nnoremap <leader>hs :GitGutterStageHunk<CR>
nnoremap <leader>hu :GitGutterUndoHunk<CR>

" NERDTree configuration
let NERDTreeShowHidden=1
nnoremap <C-w>w :call NERDTreeFocus()<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" GitGutter configuration
let g:gitgutter_enabled = 1
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '_'

" CoC configuration
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
