local create = require'languages.utils'.create_simple

local docker = create{ name = 'docker', server = 'dockerls' }
local yaml = create{ name = "yaml", server = "yamlls", image = "lspcontainers/yaml-language-server:0.18.0"}
local bash = create{ name = "bash", server = "bashls", image = "lspcontainers/bash-language-server:1.17.0"}

return {
  [require'languages.lua'.name] = require'languages.lua',
  [docker.name] = docker,
  [yaml.name] = yaml,
  [bash.name] = bash,

--  [require'languages.rust'.name] = require'languages.rust',
}
