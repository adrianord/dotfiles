local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  -- nvim-lsp
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'nvim-lua/lsp_extensions.nvim'
  use {'glepnir/lspsaga.nvim', branch = 'main'}
  use 'kabouzeid/nvim-lspinstall'
  ---
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate"
  }
  --- apperance
  use {'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons'}
  use 'folke/tokyonight.nvim'
  use {'kyazdani42/nvim-tree.lua', requires = 'nvim-web-devicons'}
  --use 'glepnir/dashboard-nvim'
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
      require('lualine').setup{
        options = {
          theme = 'tokyonight',
          extensions = { 'fzf' }
        }
      }
    end
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
    end
  }
end)

vim.cmd[[colorscheme tokyonight]]
--vim.g.dashboard_default_executive="telescope"

require'telescope'.setup{
  defaults = {
    prompt_position = "top",
    sorting_strategy = "ascending",
    layout_defaults = {
      vertical = {
        mirror = true
      },
    },
  }
}

require('bufferline').setup{
  options = {
    separator_style = "thin",
    numbers = "buffer_id",
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(_, _, diagnostics_dict)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " "
          or (e == "warning" and " " or "" )
        s = s .. n .. sym
      end
      return s
    end
  }
}


require('lspsaga').init_lsp_saga{
  code_action_keys = {
    quit = "<escape>"
  },
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = {"lua", "typescript"},
  highlight = {
    enable = true,
  }
}

local options = { noremap = true }
local map = vim.api.nvim_set_keymap
map('n', '<leader>ff', '<CMD>lua require("telescope.builtin").find_files()<CR>', options)
map('n', '<C-t>', '<CMD>lua require("telescope.builtin").find_files()<CR>', options)
map('n', '<leader>fg', '<CMD>lua require("telescope.builtin").live_grep()<CR>', options)
map('n', '<C-f>', '<CMD>lua require("telescope.builtin").live_grep()<CR>', options)
map('n', '<leader>fb', '<CMD>lua require("telescope.builtin").buffers()<CR>', options)
map('n', '<C-i>', '<C-^>', options)

map('n', '<a-cr>', '<cmd>lua require("lspsaga.codeaction").code_action()<CR>', options)

vim.cmd[[inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"]]
vim.cmd[[inoremap <expr> <S-Tab>   pumvisible() ? "\<C-n>" : "\<S-Tab>"]]

-- NvimTree
map('n', '<A-1>', '<CMD>NvimTreeToggle<CR>', options)

local global = {vim.g}
require'utils'.opts({
  nvim_tree_side = 'right',
  nvim_tree_follow = 1,
  nvim_tree_quit_on_open = 1,
  nvim_tree_lsp_diagnostics = 1,
  nvim_tree_disable_netrw = 0,
  nvim_tree_hijack_netrw = 0,
}, global)
