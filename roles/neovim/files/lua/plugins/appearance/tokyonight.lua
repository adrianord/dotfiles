local name = "tokyonight"

local function config()
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
