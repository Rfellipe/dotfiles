local lsputils = require("util.lsputils")

return {
  "neovim/nvim-lspconfig",
  event = "LazyFile",
  dependencies = {
    "mason.nvim",
    { "mason-org/mason-lspconfig.nvim", config = function() end },
  },
  opts = {
    config = vim.schedule_wrap(function(_, opts)
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
    end),
    servers = {
      ["*"] = {
        capabilities = lsputils.capabilities,
      },
      ts_ls = {
        mason = true,
        cmd = { "typescript-language-server" },
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        root_dir = lsputils.make_root_dir({
          "package.json",
          "tsconfig.json",
          "jsconfig.json",
          ".git",
        }),
      },
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
