return {
  setup = function()
    local opts = require'utils'.opts
    local o, wo, bo, g = vim.o, vim.wo, vim.bo, vim.g

    local global = {g}
    opts({
      mapleader = " "
    }, global)

    opts({
      clipboard = 'unnamedplus',
      mouse = 'a',
      hidden = true,
    })

    local window = {o, wo}
    opts({
      signcolumn = 'yes:1',
      number = true,
      relativenumber = true,
      cursorline = true,
    }, window)

    local buffer = {o, bo}
    opts({
      expandtab = true,
      textwidth = 120,
      shiftwidth = 2,
      tabstop = 2,
    }, buffer)

    vim.cmd("hi CursorLine cterm=NONE ctermbg=237 term=NONE")
  end
}
