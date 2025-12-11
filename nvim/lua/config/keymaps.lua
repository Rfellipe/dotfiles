-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- Exit insert mode with jj
vim.keymap.set("i", "jj", "<Esc>", { noremap = true })

-- Navigation remaps
local nav_opts = { noremap = true }

-- Normal mode
vim.keymap.set("n", "j", "h", nav_opts)
vim.keymap.set("n", "k", "j", nav_opts)
vim.keymap.set("n", "l", "k", nav_opts)
vim.keymap.set("n", "ç", "l", nav_opts)

-- Visual mode
vim.keymap.set("v", "j", "h", nav_opts)
vim.keymap.set("v", "k", "j", nav_opts)
vim.keymap.set("v", "l", "k", nav_opts)
vim.keymap.set("v", "ç", "l", nav_opts)

-- Window navigation
vim.keymap.set("n", "<C-k>", "<C-w>j", nav_opts)
vim.keymap.set("n", "<C-l>", "<C-w>k", nav_opts)
vim.keymap.set("n", "<C-j>", "<C-w>h", nav_opts)
vim.keymap.set("n", "<C-ç>", "<C-w>l", nav_opts)

-- Move panes around
vim.keymap.set("n", "<C-w>K", "<C-w>J", nav_opts)
vim.keymap.set("n", "<C-w>L", "<C-w>K", nav_opts)
vim.keymap.set("n", "<C-w>J", "<C-w>H", nav_opts)
vim.keymap.set("n", "<C-w>Ç", "<C-w>L", nav_opts)

-- Resize splits
vim.keymap.set("", "<C-Up>", "<C-w>+", nav_opts)
vim.keymap.set("", "<C-Down>", "<C-w>-", nav_opts)
vim.keymap.set("", "<C-Left>", "<C-w>>", nav_opts)
vim.keymap.set("", "<C-Right>", "<C-w><", nav_opts)

-- Tab management
vim.keymap.set("", "<C-t>n", ":tabnext<CR>", nav_opts)
vim.keymap.set("", "<C-t>p", ":tabprevious<CR>", nav_opts)
vim.keymap.set("", "<C-t>r", ":tabnew<CR>", nav_opts)
vim.keymap.set("", "<C-t>w", ":tabclose<CR>", nav_opts)
vim.keymap.set("", "<C-t><C-t>", ":tab term<CR>", nav_opts)
