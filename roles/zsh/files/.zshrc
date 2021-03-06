now=$(date +%s)sec

# Set up edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Set up prompt
fpath+="${ZDOTDIR}/themes/pure"
autoload -Uz promptinit
promptinit
prompt pure
zstyle :prompt:pure:path color cyan

# User emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Set <C-Left> and <C-Right>
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Set up history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
HISTFILE="${XDG_DATA_HOME:-${HOME}/.local/share}/zsh/history"
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS

# User modern completion system
autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/zcompdump-${ZSH_VERSION}"
zmodload zsh/complist
zstyle ':completion:*' menu select=0 interactive
setopt menucomplete

for file in ${ZDOTDIR}/.zsh.d/*(.); do
  source "$file"
done

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

setopt AUTO_PUSHD

echo .zshrc loaded in $(TZ=UTC date --date now-$now +%M:%S.%N)

