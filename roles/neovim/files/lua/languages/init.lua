local create = require'languages.utils'.create_simple

local docker = create{ name = 'docker', server = 'dockerls' }
local yaml = create{ name = "yaml", server = "yamlls"}
local bash = create{ name = "bash", server = "bashls"}
local rust = create{ name = "rust", server = "rust_analyzer"}
local typescript = create{ name = "typescript", server = "tsserver"}
local go = create{ name = "go", server = "gopls"}

return {
  [require'languages.lua'.name] = require'languages.lua',
  [docker.name] = docker,
  [yaml.name] = yaml,
  [bash.name] = bash,
  [rust.name] = rust,
  [typescript.name] = typescript,
--[go.name] = go,
--  [require'languages.rust'.name] = require'languages.rust',
}
