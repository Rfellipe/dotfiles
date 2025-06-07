local vim = vim

-- General Settings {{{
  -- Encoding
  vim.opt.encoding = "utf-8"
  vim.opt.fileencoding = "utf-8"

  -- Basic settings
  vim.opt.compatible = false                 -- Disable compatibility with vi which can cause unexpected issues.
  vim.opt.showmatch = true                   -- Show matching words during a search.
  vim.opt.ignorecase = true                  -- Ignore capital letters during search.
  vim.opt.mouse = "a"                        -- middle-click paste with
  vim.opt.hlsearch = true                    -- Use highlighting when doing a search.
  vim.opt.incsearch = true                   -- While searching though a file incrementally highlight matching characters as you type.
  vim.opt.tabstop = 2                        -- Set tab width to 2 spaces.
  vim.opt.softtabstop = 4                    -- see multiple spaces as tabstops so <BS> does the righ
  vim.opt.expandtab = true                   -- Use space characters instead of tabs.
  vim.opt.shiftwidth = 2                     -- Set shift width to 2 spaces.
  vim.opt.autoindent = true                  -- Enable auto identantion
  vim.opt.number = true                      -- Add numbers to each line on the left-hand side.
  vim.opt.wildmode = { "longest", "list" }   -- Make wildmenu behave like similar to Bash completion.
  vim.cmd("filetype plugin indent on")       -- Enable plugins and load plugin for the detected file type.
  vim.cmd("syntax on")                       -- Enable syntax highlighting
  vim.opt.clipboard = "unnamedplus"          -- using system clipboard
  vim.opt.cursorline = true                  -- Highlight cursor line und
  vim.opt.ttyfast = true                     -- Speed up scrolling in Vim

  -- History
  vim.opt.history = 1000                     -- Set the commands to save in history default num
  vim.cmd("filetype on")                     -- Enable type file detection. Vim will be able to
  vim.opt.backup = false                     -- Do not save backup files.
  vim.opt.scrolloff = 10                     -- Do not let cursor scroll below or above N numbe
  vim.opt.showcmd = true                     -- Show partial command you type in the last line 
  vim.opt.showmode = true                    -- Show the mode you are on the last line.
  vim.opt.wildmenu = true                    -- Enable auto completion menu after pressing TAB.
  vim.opt.writebackup = false

  -- Override the ignorecase option if searching for capital letters.
  -- This will allow you to search specifically for capital letters.
  vim.opt.smartcase = true

  -- There are certain files that we would never want to edit with Vim.
  -- Wildmenu will ignore files with these extensions.
  vim.opt.wildignore = {
    "*.docx", "*.jpg", "*.png", "*.gif", "*.pdf",
    "*.pyc", "*.exe", "*.flv", "*.img", "*.xlsx"
  }

  -- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
  -- delays and poor user experience
  vim.opt.updatetime = 300

  -- Always show the signcolumn, otherwise it would shift the text each time
  -- diagnostics appear/become resolved
  vim.opt.signcolumn = "yes"
-- }}}

-- General Key Mappings {{{
  -- Set backslash as leader key
  vim.g.mapleader = "\\"

  -- Use space to enter command mode in normal/visual mode
  vim.keymap.set("n", "<space>", ":", { noremap = true })
  vim.keymap.set("x", "<space>", ":", { noremap = true })

  -- Exit insert mode with jj
  vim.keymap.set("i", "jj", "<Esc>", { noremap = true })

  -- Navigation remaps
  local nav_opts = { noremap = true }

  -- Normal mode
  vim.keymap.set("n", "j", "h", nav_opts)
  vim.keymap.set("n", "k", "j", nav_opts)
  vim.keymap.set("n", "l", "k", nav_opts)
  vim.keymap.set("n", "ç", "l", nav_opts)

  -- Visual mode
  vim.keymap.set("v", "j", "h", nav_opts)
  vim.keymap.set("v", "k", "j", nav_opts)
  vim.keymap.set("v", "l", "k", nav_opts)
  vim.keymap.set("v", "ç", "l", nav_opts)

  -- Window navigation
  vim.keymap.set("n", "<C-k>", "<C-w>j", nav_opts)
  vim.keymap.set("n", "<C-l>", "<C-w>k", nav_opts)
  vim.keymap.set("n", "<C-j>", "<C-w>h", nav_opts)
  vim.keymap.set("n", "<C-ç>", "<C-w>l", nav_opts)

  -- Move panes around
  vim.keymap.set("n", "<C-w>K", "<C-w>J", nav_opts)
  vim.keymap.set("n", "<C-w>L", "<C-w>K", nav_opts)
  vim.keymap.set("n", "<C-w>J", "<C-w>H", nav_opts)
  vim.keymap.set("n", "<C-w>Ç", "<C-w>L", nav_opts)

  -- Resize splits
  vim.keymap.set("", "<C-Up>", "<C-w>+", nav_opts)
  vim.keymap.set("", "<C-Down>", "<C-w>-", nav_opts)
  vim.keymap.set("", "<C-Left>", "<C-w>>", nav_opts)
  vim.keymap.set("", "<C-Right>", "<C-w><", nav_opts)

  -- Tab management
  vim.keymap.set("", "<C-t>n", ":tabnext<CR>", nav_opts)
  vim.keymap.set("", "<C-t>p", ":tabprevious<CR>", nav_opts)
  vim.keymap.set("", "<C-t>r", ":tabnew<CR>", nav_opts)
  vim.keymap.set("", "<C-t>w", ":tabclose<CR>", nav_opts)
  vim.keymap.set("", "<C-t><C-t>", ":tab term<CR>", nav_opts)
-- }}}


-- Basic error handling wrapper for module loading
local function safe_require(module)
  local success, result = pcall(require, module)
  if not success then
    vim.notify("Error loading module '" .. module .. "': " .. result, vim.log.levels.ERROR)
    return nil
  end
  return result
end

safe_require('user.plugins')
safe_require('user.scripts')
safe_require('user.lsp')
safe_require('user.theme')
