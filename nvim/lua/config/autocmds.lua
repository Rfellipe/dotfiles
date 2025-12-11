-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local lsputils = require("util.lsputils")

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

-- Custom commands
vim.api.nvim_create_user_command("Bda", "%bdelete", {})
vim.api.nvim_create_user_command("Bo", '%bdelete | edit # | normal `"', {})

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
