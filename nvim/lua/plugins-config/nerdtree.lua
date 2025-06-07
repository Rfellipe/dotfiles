-- NERDTree Mappings
vim.keymap.set("n", "<leader>e", ":NERDTreeToggle<CR>", nav_opts)
vim.keymap.set("n", "<leader>fe", ":NERDTreeFocus<CR>", nav_opts)

-- If another buffer tries to replace NERDTree, put it in the other window and bring back NERDTree
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    local current_win = vim.fn.winnr()
    local prev_buf = vim.fn.bufname("#")
    local curr_buf = vim.fn.bufname("%")
    local total_wins = vim.fn.winnr("$")

    if current_win == vim.fn.winnr("h")
      and prev_buf:match("NERD_tree_%d+")
      and not curr_buf:match("NERD_tree_%d+")
      and total_wins > 1
    then
      local buf = vim.fn.bufnr()
      vim.cmd("buffer #")
      vim.cmd("normal! <C-W>w")
      vim.cmd("buffer " .. buf)
    end
  end
})

-- Open the existing NERDTree on each new tab
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  callback = function()
    if vim.bo.buftype ~= "quickfix" and vim.fn.getcmdwintype() == "" then
      vim.cmd("silent NERDTreeMirror")
    end
  end
})

print("File explorer initialized!")
