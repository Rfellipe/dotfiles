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
      clangd = {
        keys = {
          { "<leader>ch", "<cmd>LspClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
        },
        root_markers = {
          "compile_commands.json",
          "compile_flags.txt",
          "configure.ac", -- AutoTools
          "Makefile",
          "configure.ac",
          "configure.in",
          "config.h.in",
          "meson.build",
          "meson_options.txt",
          "build.ninja",
          ".git",
        },
        capabilities = {
          offsetEncoding = { "utf-16" },
        },
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      },
    },
  },
}
