local U = {}
LSPUtils = U

------------------------------------------------------------
-- LSP capabilities (nvim-cmp integration)
------------------------------------------------------------
U.capabilities = vim.lsp.protocol.make_client_capabilities()

local has_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if has_cmp then
  U.capabilities = cmp_lsp.default_capabilities(LSPUtils.capabilities)
end

------------------------------------------------------------
-- Helpers
------------------------------------------------------------
function U.make_root_dir(patterns)
  return function(fname)
    local root = vim.fs.root(fname, patterns)
    return root or vim.fs.dirname(fname)
  end
end

function U.setup_server(name, opts)
  local filetypes = opts.filetypes or {}
  opts.filetypes = nil

  vim.api.nvim_create_autocmd("FileType", {
    pattern = filetypes,
    callback = function(ev)
      local bufnr = ev.buf
      local fname = vim.api.nvim_buf_get_name(bufnr)
      if fname == "" then
        return
      end

      local root_dir = opts.root_dir and opts.root_dir(fname) or vim.fs.dirname(fname)

      vim.lsp.start(vim.tbl_deep_extend("force", {
        name = name,
        root_dir = root_dir,
        capabilities = U.capabilities,
        -- on_attach = on_attach,
      }, opts))
    end,
  })
end

------------------------------------------------------------
-- Helpers for clangd (root dir + fs check)
------------------------------------------------------------
function U.path_exists(path)
  local uv = vim.uv or vim.loop
  return uv.fs_stat(path) ~= nil
end

function U.get_root_dir(fname)
  -- Similar to lspconfig.util.root_pattern('compile_commands.json', '.clangd', '.git')
  local root = vim.fs.root(fname, { "compile_commands.json", ".clangd", ".git" })
  return root or vim.fs.dirname(fname)
end

return U
