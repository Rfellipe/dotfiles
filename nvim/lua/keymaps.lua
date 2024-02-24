-- define common options
local opts = {
    noremap = true, -- non-recursive
    silent = true, -- do not show message
}

-----------------
-- Normal mode --
-----------------

-- Navigation Keys
vim.keymap.set('n', 'j', 'h', opts)
vim.keymap.set('n', 'k', 'j', opts)
vim.keymap.set('n', 'l', 'k', opts)
vim.keymap.set('n', 'ç', 'l', opts)

vim.keymap.set('n', '<C-j>', '<C-h>', opts)
vim.keymap.set('n', '<C-k>', '<C-j>', opts)
vim.keymap.set('n', '<C-l>', '<C-k>', opts)
vim.keymap.set('n', '<C-ç>', '<C-l>', opts)


-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- for nvim-tree
-- default leader key: \
vim.keymap.set('n', '<C-b>', ':NvimTreeToggle<CR>', opts)

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

vim.keymap.set('v', 'j', 'h', opts)
vim.keymap.set('v', 'k', 'j', opts)
vim.keymap.set('v', 'l', 'k', opts)
vim.keymap.set('v', 'ç', 'l', opts)
