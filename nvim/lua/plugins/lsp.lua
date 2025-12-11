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
        },
      },
      config = function() end,
    },
  },
  opts = {
    servers = {
      config = function() end,
      ["*"] = {
        capabilities = lsputils.capabilities,
      },
      ts_ls = {},
      lua_ls = {},
      pyright = {},
      rust_analyzer = {},
      jqls = {},
      bashls = {},
      tailwindcss = {},
      clangd = {
        mason = true,
        settings = function()
          vim.api.nvim_create_autocmd("FileType", {
            pattern = { "c", "cpp", "objc", "objcpp", "cuda" },
            callback = function(ev)
              local bufnr = ev.buf
              local fname = vim.api.nvim_buf_get_name(bufnr)
              if fname == "" then
                return
              end

              local root_dir = lsputils.get_root_dir(fname)
              if not root_dir then
                return
              end

              -- Example:
              -- root_dir = /home/fellipe/Projects/C/Zephyr/applications
              --
              -- Zephyr project root is one directory above:
              -- /home/fellipe/Projects/C/Zephyr
              local zephyr_root = vim.fs.dirname(root_dir)

              local build_dir = root_dir .. "/build"
              local build_db = build_dir .. "/compile_commands.json"

              local cmd = { "clangd" }

              if lsputils.path_exists(build_db) then
                cmd = {
                  "clangd",
                  "--compile-commands-dir=" .. build_dir,
                  "--path-mappings=/workdir=" .. zephyr_root,
                }
              end

              vim.lsp.start({
                name = "clangd",
                cmd = cmd,
                root_dir = root_dir,
                -- on_attach = on_attach,
                capabilities = lsputils.capabilities,
              })
            end,
          })
        end,
      },
    },
  },
}
