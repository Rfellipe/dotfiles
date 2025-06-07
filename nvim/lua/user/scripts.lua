-- Enable code folding using indent by default
vim.opt.foldmethod = "indent"

-- Use marker method for folding in Vimscript files
vim.api.nvim_create_augroup("filetype_vim", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "filetype_vim",
  pattern = "vim",
  callback = function()
    vim.opt_local.foldmethod = "marker"
  end
})

-- Enable persistent undo if Neovim version >= 0.5 (Vim 7.3 equivalent)
-- Neovim always supports undofiles
vim.opt.undodir = vim.fn.expand("~/.vim/backup")
vim.opt.undofile = true
vim.opt.undoreload = 10000

-- Cursor shape: line in insert mode, block otherwise
-- These only apply to terminals that support DECSCUSR (like xterm or alacritty)
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

-- Custom commands
vim.api.nvim_create_user_command("Bda", "%bdelete", {})
vim.api.nvim_create_user_command("Bo", '%bdelete | edit # | normal `"', {})

print('Custom scripts initialized')
