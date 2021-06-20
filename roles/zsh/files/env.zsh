xdg_config_home="${XDG_CONFIG_HOME:-${HOME}/.config}"
xdg_cache_home="${XDG_CACHE_HOME:-${HOME}/.cache}"
xdg_data_home=${XDG_DATA_HOME:-${HOME}/.local}

export PATH=${PATH}:$xdg_data_home/bin

# wget
export WGETRC="${xdg_config_home}/wgetrc"
echo hsts-file \= "${xdg_cache_home}/wget-hsts" >> "${xdg_config_home}/wgetrc"

# less
[[ ! -d "${xdg_cache_home}/less" ]] && mkdir "${xdg_cache_home}/less"
export LESSKEY="${xdg_config_home}/less/lesskey"
export LESSHISTFILE="${xdg_cache_home}/less/history"

if type cargo > /dev/null; then
  source $HOME/.cargo/env
fi

if type kubectl > /dev/null; then
  source <(kubectl completion zsh)
fi

if type helm > /dev/null; then
  source <(helm completion zsh)
fi

if [ -d "/usr/local/go/bin" ]; then
  export PATH=$PATH:/usr/local/go/bin
fi

if [ -d "$HOME/.pulumi/bin" ]; then
  export PATH=$PATH:$HOME/.pulumi/bin
fi

if type gcloud > /dev/null; then
  source /snap/google-cloud-sdk/current/completion.zsh.inc
fi

if type pulumi > /dev/null; then
  source <(pulumi gen-completion zsh)
fi

