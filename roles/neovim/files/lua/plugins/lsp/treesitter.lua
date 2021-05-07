
local function config()
  local supported_languages = require'nvim-treesitter.parsers'.get_parser_configs()

  local languages = {}
  for name, _ in pairs(vim.tbl_keys(require'languages')) do
    if supported_languages[name] then
      languages.insert(name)
    end
  end

  require'nvim-treesitter.configs'.setup {
    ensure_installed = languages,
    highlight = {
      enable = true,
    }
  }
end

return {
  setup = function(use)
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ":TSUpdate",
      config = config
    }
  end
}
