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

-- Easy navigation
keymap("n", "E", "$", opts)
keymap("n", "B", "^", opts)

-- Quick access
keymap("n", "<leader>h", ":noh<CR>", opts)

-- Custom function to open markdown links
function _G.open_markdown_link()
    local line = vim.fn.getline('.')
    local link = line:match('%[.-%]%((.-)%)')
    if link then
        if vim.fn.has('mac') == 1 then
            -- vim.fn.system('open ' .. link)
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
