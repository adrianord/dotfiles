# Auto-completion
# ---------------
[[ $- == *i* ]] && source $(dpkg -L fzf | grep completion.zsh) >> /dev/null

# Key bindings
# ------------
source $(dpkg -L fzf | grep key-bindings.zsh)

# Overrides
# ---------
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

export FZF_PREVIEW_BIND="--bind alt-k:preview-up,alt-j:preview-down"
export FZF_LS_PREVIEW="ls -la --color {}"
export FZF_BAT_PREVIEW="bat --decorations always --color always {}"
export FZF_BAT_LS_PREVIEW="if [ -d {} ]; then ${FZF_LS_PREVIEW} ; else ${FZF_BAT_PREVIEW}; fi"

export FZF_DEFAULT_COMMAND='fd --type d --type f --hidden --follow --exclude .git'

export FZF_CTRL_T_COMMAND='fd --type d --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_OPTS="${FZF_PREVIEW_BIND} --preview '${FZF_BAT_LS_PREVIEW}'"

export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_ALT_C_OPTS="${FZF_PREVIEW_BIND} --preview '${FZF_LS_PREVIEW}'"

export FZF_DEFAULT_OPTS='--height 40% --reverse'
export FZF_TAB_CONTINUOUS_TRIGGER=ctrl-i

function fzf-vim-open {
  file=$(__fsel | xargs)
  if [ $file ]; then
    vim $file < /dev/tty
  fi
  zle reset-prompt
}

function fzf-code-open {
  file=$(__fsel | xargs)
  if [ $file ]; then
    code $file
  fi
  zle reset-prompt
}

zle -N fzf-vim-open
zle -N fzf-code-open

bindkey '^T' fzf-vim-open
bindkey '^P' fzf-code-open
bindkey '^F' fzf-cd-widget
bindkey '^Y' fzf-file-widget

_fzf_complete_git() {
    ARGS="$@"
    local branches
    branches=$(git branch -vv --all)
    if [[ $ARGS == 'git co'* ]]; then
        _fzf_complete "--reverse --multi" "$@" < <(
            echo $branches
        )
    else
        eval "zle ${fzf_default_completion:-expand-or-complete}"
    fi
}

_fzf_complete_git_post() {
    awk '{print $1}'
}
