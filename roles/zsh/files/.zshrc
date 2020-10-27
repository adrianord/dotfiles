now=$(date +%s)sec

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

# Keep 1000 lines of history within shell
HISTSIZE=1000
SAVEHIST=1000
HISTFILE="${XDG_DATA_HOME:-${HOME}/.local/share}/zsh/history"

# User modern completion system
autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/zcompdump-${ZSH_VERSION}"
zmodload zsh/complist
zstyle ':completion:*' menu select=0 interactive
setopt menucomplete

for file in ${ZDOTDIR}/.zsh.d/*(.); do
  source "$file"
done

echo .zshrc loaded in $(TZ=UTC date --date now-$now +%M:%S.%N)
