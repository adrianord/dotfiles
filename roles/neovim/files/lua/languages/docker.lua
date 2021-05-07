local name = 'docker'
local server = 'dockerls'

local default_config = require'lspconfig'[server].document_config
local config = {
  on_new_config = function(new_config, new_root_dir)
    new_config.cmd = require'lspcontainers'.command(server, { root_dir = new_root_dir })
  end
}

return {name = name, server = server, config = vim.tbl_deep_extend("keep", config, default_config)}
