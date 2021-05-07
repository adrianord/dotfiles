local function config()
  local languages = require'languages'
  local lspconfig = require'lspconfig'

  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    -- Mappings.
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
      buf_set_keymap("n", "<space>fr", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
      buf_set_keymap("n", "<C-k><C-d>", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    end
    if client.resolved_capabilities.document_range_formatting then
      buf_set_keymap("v", "<space>fr", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
      buf_set_keymap("v", "<C-k><C-d>", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end
  end

  local function make_config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    return {
      root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname)
        or require'utils'.find_session_directory()
      end,
      capabilities = capabilities,
      on_attach = on_attach
    }
  end

  local function setup_servers()
    local base_config = make_config()
    for _, language in pairs(languages) do
      local configuration = vim.tbl_deep_extend("force", language.config, base_config)
      lspconfig[language.server].setup(configuration)
    end
  end
  setup_servers()

  --local lua_server = "sumneko_lua"
  --local base_config = make_config()
  --local lua_config = vim.tbl_deep_extend("keep", languages["lua"].config, base_config)
  --require'lspconfig'[lua_server].setup(lua_config)
--
--  local docker_server = "dockerls"
--  local docker_config = vim.tbl_deep_extend("keep", {on_new_config = function(new_config, new_root_dir)
--    new_config.cmd = require'lspcontainers'.command(docker_server, {root_dir = new_root_dir})
--  end}, base_config)
--  require'lspconfig'[docker_server].setup(docker_config)
--  local typescript_server = "tsserver"
--  local typescript_config = vim.tbl_deep_extend("keep", {on_new_config = function(new_config, new_root_dir)
--    new_config.cmd = require'lspcontainers'.command(typescript_server, {
--      root_dir = new_root_dir,
--      additional_languages = { tsserver = "lspcontainers/typescript-language-server:0.5.1"}
--      })
--  end}, base_config)
-- require'lspconfig'[typescript_server].setup(typescript_config)

  vim.cmd[[inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"]]
  vim.cmd[[inoremap <expr> <S-Tab> pumvisible() ? "\<C-n>" : "\<S-Tab>"]]

  -- TODO: !!! Remove this once processId is configurable !!!
  -- https://github.com/neovim/neovim/issues/14504
  --vim.loop.getpid = function() return nil end
end



return {
  setup = function(use)
    vim.lsp.set_log_level("trace")
    use {
      'neovim/nvim-lspconfig',
      requires = {
        'kabouzeid/nvim-lspinstall',
        'nvim-lua/lsp_extensions.nvim',
        {'adrianord/lspcontainers.nvim', branch='feat_table_languages'}
      },
      config = config
    }
  end
}

