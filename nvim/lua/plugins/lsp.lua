local lsputils = require("util.lsputils")

return {
  "neovim/nvim-lspconfig",
  event = "LazyFile",
  dependencies = {
    "mason.nvim",
    {
      "mason-org/mason-lspconfig.nvim",
      opts = {
        ensure_installed = {
          "ts_ls",
          "clangd",
          "lua_ls",
          "pyright",
          "rust_analyzer",
          "jqls",
          "bashls",
          "tailwindcss",
          "gopls",
          "postgres_lsp",
        },
      },
    },
  },
  opts = {
    servers = {
      ts_ls = {},
      lua_ls = {},
      pyright = {},
      rust_analyzer = {},
      jqls = {},
      bashls = {},
      tailwindcss = {},
      postgres_lsp = {},
      denols = {},
      gopls = {},
      clangd = {},
      qmlls = {
        cmd = { "qmlls", "-E" },
        filetypes = { "qml", "qmljs" },
        root_markers = { ".git" },
      },
    },
  },
}
