local function config()
  require('lualine').setup{
    options = {
      theme = require'plugins.appearance.theme'.name,
      extensions = { 'fzf' }
    }
  }
end

return {
  setup = function(use)
    use {
      'hoob3rt/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true},
      config = config
    }
  end
}
