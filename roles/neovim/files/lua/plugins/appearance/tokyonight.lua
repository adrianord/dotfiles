local name = "tokyonight"

local function config()
  vim.cmd('colorscheme '..name)
end

return {
  name = name,
  setup = function(use)
    use 'folke/tokyonight.nvim'
    config()
  end
}
