local name = "tokyonight"

local function config()
  vim.cmd('colorscheme tokyonight')
end

return {
  name = name,
  setup = function(use)
    use {
      'folke/tokyonight.nvim',
      config = config
    }
  end
}
