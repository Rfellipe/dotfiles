-- Check if which-key is available
local has_which_key, wk = pcall(require, "which-key")
if not has_which_key then
  print("Warning: which-key not found. Key binding help won't be available.")
  return
end

-- Set up which-key with error handling
local setup_ok, _ = pcall(wk.setup, {
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 20,
    },
    presets = {
      operators = true,
      motions = true,
      text_objects = true,
      windows = true,
      nav = true,
      z = true,
      g = true,
    },
  },
  win = {
    border = "rounded",
    padding = { 2, 2, 2, 2 },
  },
  layout = {
    height = { min = 4, max = 25 },
    width = { min = 20, max = 50 },
  },
  filter = false,
})

if not setup_ok then
  print("Error setting up which-key. Key binding help won't work correctly.")
  return
end

-- Register key bindings with which-key
local add_ok _ pcall(wk.add, {
  { "<leader>b", group = "Buffer" },
  { "<leader>bd", "<cmd>bdelete<cr>", desc = "Delete Buffer" },
  { "<leader>bn", "<cmd>bnext<cr>", desc = "Next Buffer" },
  { "<leader>bp", "<cmd>bprevious<cr>", desc = "Previous Buffer" },
  { "<leader>e", "<cmd>NERDTreeToggle<cr>", desc = "Explorer" },
  { "<leader>f", group = "File" },
  { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
  { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
  { "<leader>fn", "<cmd>enew<cr>", desc = "New File" },
  { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
  { "<leader>l", group = "LSP" },
  { "<leader>lR", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
  { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
  { "<leader>ld", "<cmd>Telescope lsp_definitions<cr>", desc = "Definitions" },
  { "<leader>lf", "<cmd>lua vim.lsp.buf.format()<cr>", desc = "Format" },
  { "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Hover" },
  { "<leader>lr", "<cmd>Telescope lsp_references<cr>", desc = "References" }
})

if not add_ok then
  print("Error registering which-key bindings.")
  return
end

print("Key binding help initialized!")
