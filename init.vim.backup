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
set timeoutlen=500

" Set leader key
let mapleader = " "

" Don't use Ex mode, use Q for formatting
map Q gq

" Plugin management
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
Plug 'tpope/vim-surround'
call plug#end()

" Color scheme
colorscheme dracula

" Key mappings

" General
inoremap jk <Esc>
nnoremap U <C-R>

" File operations
nnoremap <leader>w :w<CR>
nnoremap <leader>x :wq<CR>
nnoremap <leader>ve :e $MYVIMRC<CR>
nnoremap <leader>vr :source $MYVIMRC<CR>

" Navigation
nnoremap H ^
nnoremap L $

" Window management
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <leader>sv :vsplit<CR>
nnoremap <leader>sh :split<CR>
nnoremap <leader>sc :close<CR>
nnoremap <leader>me <C-w>_<C-w>|
nnoremap <leader>= <C-w>=

" Resize splits
nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>
nnoremap <leader>> :resize +5<CR>
nnoremap <leader>< :resize -5<CR>

" Buffer navigation
nnoremap <leader>] :bnext<CR>
nnoremap <leader>[ :bprevious<CR>
nnoremap <leader>b :Telescope buffers<CR>

" Close windows and buffers (matching IdeaVim setup)
nnoremap <leader>qx :q<CR>
nnoremap <leader>qa :qall<CR>
nnoremap <leader>qo :%bd\|e#\|bd#<CR>
nnoremap <leader>qt :tabclose<CR>

" Search and replace
nnoremap <leader>se <cmd>Telescope<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fp <cmd>Telescope live_grep<cr>

" Code navigation and editing
nnoremap <leader>gc <cmd>Telescope git_commits<cr>
nnoremap <leader>gf <cmd>Telescope git_files<cr>
nnoremap <leader>a <cmd>Telescope commands<cr>
nnoremap <leader>rl <cmd>Telescope oldfiles<cr>
nnoremap <leader>rr <cmd>Telescope find_files<cr>
nnoremap <leader>nd :lua require'telescope.builtin'.file_browser()<CR>
nnoremap <leader>ro <C-^>
nnoremap <leader>sw :set wrap!<CR>

" LSP
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap <leader>rf <cmd>Telescope lsp_references<cr>
nnoremap <leader>i <cmd>Telescope lsp_code_actions<cr>
nnoremap <leader>qi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>su <cmd>Telescope lsp_references<cr>
nnoremap <leader>oi <cmd>lua vim.lsp.buf.execute_command({command = "_typescript.organizeImports", arguments = {vim.fn.expand("%:p")}})<CR>
nnoremap <leader>pi :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>sd :lua vim.diagnostic.open_float()<CR>

" Git
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gl :Git pull<CR>

" NvimTree (similar to NERDTree)
nnoremap <leader>pt :NvimTreeToggle<CR>
nnoremap <leader>tp :NvimTreeToggle<CR>

" Commentary
nnoremap <leader>/ :Commentary<CR>

" Terminal mappings
nnoremap <leader>tt :ToggleTerm<CR>

" Markdown Preview
nnoremap <leader>mp :MarkdownPreview<CR>
nnoremap <leader>ms :MarkdownPreviewStop<CR>

" Move selected lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Go to exact window
nnoremap <leader>1 :1wincmd w<CR>
nnoremap <leader>2 :2wincmd w<CR>
nnoremap <leader>3 :3wincmd w<CR>
nnoremap <leader>4 :4wincmd w<CR>
nnoremap <leader>5 :5wincmd w<CR>
nnoremap <leader>6 :6wincmd w<CR>
nnoremap <leader>7 :7wincmd w<CR>
nnoremap <leader>8 :8wincmd w<CR>
nnoremap <leader>9 :9wincmd w<CR>

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
local servers = { 'pyright', 'tsserver', 'html', 'cssls', 'bashls', 'jsonls', 'marksman' }
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

-- Global mappings
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
EOF
