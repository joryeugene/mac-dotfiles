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

-- Enhanced function to open URLs and markdown links
function _G.open_markdown_link()
    local line = vim.fn.getline('.')
    local col = vim.fn.col('.')

    -- Try to find a URL or markdown link under the cursor
    local url = nil

    -- Check for markdown link [text](url)
    local markdown_link = line:match('%[.-%]%((.-)%)')
    if markdown_link then
        url = markdown_link
    else
        -- Check for plain URL
        local word = vim.fn.expand('<cWORD>')
        if word:match('^https?://') or word:match('^www%.') then
            url = word
        end
    end

    if url then
        -- Handle different operating systems
        if vim.fn.has('mac') == 1 then
            vim.fn.system('open ' .. vim.fn.shellescape(url))
        elseif vim.fn.has('unix') == 1 then
            vim.fn.system('xdg-open ' .. vim.fn.shellescape(url))
        elseif vim.fn.has('win32') == 1 then
            vim.fn.system('start ' .. vim.fn.shellescape(url))
        end
    else
        -- Fallback to netrw's gx if no URL found
        vim.api.nvim_command('normal! gx')
    end
end

-- Map 'gx' to open links
vim.api.nvim_set_keymap('n', 'gx', ':lua open_markdown_link()<CR>', {noremap = true, silent = true})

-- Also map 'gx' in visual mode to handle selected URLs
vim.api.nvim_set_keymap('v', 'gx', ':<C-u>lua open_markdown_link()<CR>', {noremap = true, silent = true})

return M
