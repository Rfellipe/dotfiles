local Plug = vim.fn['plug#']

-- Plugin Declaritions
vim.call('plug#begin')
  -- Deactivated
    -- Plug('neoclide/coc.nvim', { ['branch'] = 'release' }) 
    -- Plug('rust-lang/rust.vim')

  Plug('nvim-lua/plenary.nvim') -- Utility Functions

  -- Treesitter for syntax highlighting
    Plug( 
      'nvim-treesitter/nvim-treesitter', 
      { ['do'] = 'TSUpdate' }
    )

  -- LSP support
    Plug("neovim/nvim-lspconfig") -- Base LSP configurations
     -- Server installation manager
     Plug("williamboman/mason.nvim")
     Plug("williamboman/mason-lspconfig.nvim")

  -- Autocompletion system
    Plug("hrsh7th/nvim-cmp")
      Plug("hrsh7th/cmp-nvim-lsp") -- LSP source for nvim-cmp
      Plug("hrsh7th/cmp-buffer")   -- Buffer source
      Plug("hrsh7th/cmp-path")     -- Path source
      Plug("L3MON4D3/LuaSnip")     -- Snippet engine
      Plug("saadparwaiz1/cmp_luasnip") -- Snippet source

  -- File Explorer
    Plug('preservim/nerdtree')
    Plug('nvim-telescope/telescope.nvim')

  -- General Utility
    Plug('folke/which-key.nvim')
    Plug('preservim/nerdcommenter')
    Plug('terryma/vim-multiple-cursors')
    Plug('ryanoasis/vim-devicons')
    Plug('SirVer/ultisnips')
    Plug('airblade/vim-gitgutter')
    Plug('mhinz/vim-startify')

  -- Theme
    Plug('scottmckendry/cyberdream.nvim')
vim.call('plug#end')

-- Basic error handling wrapper for module loading
local function safe_require(module)
  local success, result = pcall(require, module)
  if not success then
    vim.notify("Error loading module '" .. module .. "': " .. result, vim.log.levels.ERROR)
    return nil
  end
  return result
end

-- Plugin Configs
safe_require('plugins-config.treesitter')   -- TreeSitter config
safe_require('plugins-config.nvim-cmp')     -- Nvim-cmp config
safe_require('plugins-config.nerdtree')     -- NERDTree config
safe_require('plugins-config.telescope')    -- Telescope config
safe_require('plugins-config.keymap')       -- Keymap helper config

print('All plugins started')
