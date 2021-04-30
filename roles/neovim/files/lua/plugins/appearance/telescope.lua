local function config()
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

  local options = { noremap = true }
  local map = vim.api.nvim_set_keymap
  map('n', '<leader>ff', '<CMD>lua require("telescope.builtin").find_files()<CR>', options)
  map('n', '<C-t>', '<CMD>lua require("telescope.builtin").find_files()<CR>', options)
  map('n', '<leader>fg', '<CMD>lua require("telescope.builtin").live_grep()<CR>', options)
  map('n', '<C-f>', '<CMD>lua require("telescope.builtin").live_grep()<CR>', options)
  map('n', '<leader>fb', '<CMD>lua require("telescope.builtin").buffers()<CR>', options)
end

return {
  setup = function(use)
    use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
      config = config
    }
  end
}
