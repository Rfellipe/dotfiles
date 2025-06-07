require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "lua", "vim", "vimdoc", "javascript", "typescript", "python", "rust",
    "go", "html", "css", "json", "yaml", "toml", "markdown", "bash"
  },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<BS>",
    }
  }
}

print('Treesitter initialized')
