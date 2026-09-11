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
      pyright = {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = {
          "pyrightconfig.json",
          "pyproject.toml",
          "setup.py",
          "setup.cfg",
          "requirements.txt",
          "Pipfile",
          ".git",
        },
        ---@type lspconfig.settings.pyright
        settings = {
          pyright = {
            disableTaggedHints = true,
          },
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "openFilesOnly",
            },
          },
        },
      },
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
      ginko_ls = {},
    },
  },
}
