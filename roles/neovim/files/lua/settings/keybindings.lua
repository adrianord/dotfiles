return {
  setup = function()
    local options = { noremap = true }
    local map = vim.api.nvim_set_keymap
    map('n', '<C-i>', '<C-^>', options)
  end
}
