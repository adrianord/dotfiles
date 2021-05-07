local name = 'lua'
local server = 'sumneko_lua'

local default_config = require'lspconfig'[server].document_config

local settings = {
  Lua = {
    runtime = {
      version = 'LuaJIT',
      path = {
        '?.lua',
        '?/?.lua'
      }
  },
    diagnostics = {
      globals = {
        -- Get the language server to recognize the `vim` global
        'vim',
        'fun'
      },
    },
    workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
       },
      },
      telemetry = {
        enable = false,
    },
  };
}

local config = {
  settings = settings,
  on_new_config = function(new_config, new_root_dir)
    new_config.cmd = require'lspcontainers'.command(server, { root_dir = new_root_dir })
  end
}

return {name = name, server = server, config = vim.tbl_deep_extend("keep", config, default_config)}

