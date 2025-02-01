-- Core Neovim settings that apply to both VSCode and regular Neovim
local M = {}

-- General settings
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 5
vim.opt.timeoutlen = 500
vim.opt.updatetime = 300
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.hidden = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.cmdheight = 2
vim.opt.shortmess:append("c")

-- Key mappings that work in both environments
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Navigation
keymap("n", "H", ":bprevious<CR>", opts)
keymap("n", "L", ":bnext<CR>", opts)
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

-- File operations
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>x", ":x<CR>", opts)

-- Quick save and quit
keymap("n", "WW", ":w!<CR>", opts)
keymap("n", "QQ", ":q!<CR>", opts)

-- Easy navigation
keymap("n", "E", "$", opts)
keymap("n", "B", "^", opts)

-- Resize splits
keymap("n", "<C-W>,", ":vertical resize -10<CR>", opts)
keymap("n", "<C-W>.", ":vertical resize +10<CR>", opts)

-- Windows and splits
keymap("n", "<leader>sv", ":vsplit<CR>", opts)
keymap("n", "<leader>sh", ":split<CR>", opts)
keymap("n", "<leader>sc", ":close<CR>", opts)

-- Quick access
keymap("n", "<leader>j", ":e /Users/jory/Documents/calmhive/hub.md<CR>", opts)
keymap("n", "<leader>vr", ":source $MYVIMRC<CR>", opts) -- Refresh Neovim state
keymap("n", "<leader>vc", ":e $MYVIMRC<CR>", opts) -- Open init.lua for editing
keymap("n", "<leader>m", ":messages<CR>", opts) -- Open messages
keymap("n", "<leader>l", ":Lazy<CR>", opts) -- Open Lazy plugin manager
keymap("n", "<leader>o", ":Telescope buffers<CR>", opts) -- Open buffer list

-- Utility
keymap("n", "<leader>h", ":noh<CR>", opts)
keymap("n", "<leader>z", ":ZenMode<CR>", opts)
keymap("n", "<leader>\\", ":set wrap!<CR>", opts)

-- Custom function to open markdown links
function _G.open_markdown_link()
    local line = vim.fn.getline('.')
    local link = line:match('%[.-%]%((.-)%)')
    if link then
        if vim.fn.has('mac') == 1 then
            vim.fn.system('open ' .. link)
        elseif vim.fn.has('unix') == 1 then
            vim.fn.system('xdg-open ' .. link)
        elseif vim.fn.has('win32') == 1 then
            vim.fn.system('start ' .. link)
        end
    else
        vim.api.nvim_command('normal! gx')
    end
end

-- Map 'gx' to open markdown links
vim.api.nvim_set_keymap('n', 'gx', ':lua open_markdown_link()<CR>', {noremap = true, silent = true})

return M
