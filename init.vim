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
set termguicolors

" Don't use Ex mode, use Q for formatting
map Q gq

" Install vim-plug if not found
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.local/share/nvim/plugged')
" Plugins
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-lualine/lualine.nvim'
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'folke/which-key.nvim'
Plug 'akinsho/toggleterm.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
call plug#end()

" Plugin configurations
" Dracula theme
colorscheme dracula

" Lua configurations
lua << EOF
-- nvim-tree configuration
require("nvim-tree").setup{}

-- lualine configuration
require('lualine').setup {
  options = {
    theme = 'dracula'
  }
}

-- Gitsigns configuration
require('gitsigns').setup()

-- Telescope configuration
local telescope = require('telescope')
telescope.setup{}

-- Treesitter configuration
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "python", "javascript", "html", "css" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- LSP configuration
local lspconfig = require('lspconfig')
local servers = { 'pyright', 'tsserver', 'html', 'cssls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup{}
end

-- nvim-cmp configuration
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

-- Which-key configuration
require("which-key").setup {}

-- ToggleTerm configuration
require("toggleterm").setup{
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  start_in_insert = true,
  persist_size = true,
  direction = 'float',
}

-- Indent-blankline configuration
require("ibl").setup {}
EOF

" Key mappings
" Commentary
noremap <leader>/ :Commentary<CR>

" Toggle Markdown Preview
nnoremap <leader>mp :MarkdownPreview<CR>
nnoremap <leader>ms :MarkdownPreviewStop<CR>

" EasyMotion
map <leader>w <Plug>(easymotion-bd-w)

" Telescope mappings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" LSP mappings
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" NvimTree
nnoremap <leader>n :NvimTreeToggle<CR>

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
nnoremap <leader>wh <C-W>h
nnoremap <leader>wj <C-W>j
nnoremap <leader>wk <C-W>k
nnoremap <leader>wl <C-W>l

" Split creation
nnoremap <leader>vs :vsplit<CR>
nnoremap <leader>ns :split<CR>

" Buffer navigation
nnoremap <leader>q :bdelete<CR>
nnoremap <leader>qa :%bd<CR>
nnoremap <leader>qo :%bd<CR>:execute 'bwipeout' . (v:lua.pcall(function() vim.fn.bufnr('#') end) and ' #' or '')<CR>
nnoremap <leader>] :bnext<CR>
nnoremap <leader>[ :bprevious<CR>

" Resize splits
nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>
nnoremap <leader>> :resize +5<CR>
nnoremap <leader>< :resize -5<CR>

" Fugitive mappings
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gl :Git pull<CR>

" Better escape
inoremap jk <Esc>

" Terminal mappings
tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
