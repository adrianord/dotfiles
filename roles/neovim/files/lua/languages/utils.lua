local function create_simple(opts)
  local name = opts.name
  local server = opts.server or name
  local additional_languages =  {}
  if opts.image then
    additional_languages = { [server] = opts.image }
  end
  local default_config = require'lspconfig'[server].document_config
  local config = {
  on_new_config = function(new_config, new_root_dir)
    new_config.cmd = require'lspcontainers'.command(server, { root_dir = new_root_dir, additional_languages=additional_languages})
  end,
  before_init = function(initialize_params)
    initialize_params.processId = vim.NIL
  end
}

  return {name = name, server = server, config = vim.tbl_deep_extend("keep", config, default_config)}
end

return { create_simple = create_simple }
