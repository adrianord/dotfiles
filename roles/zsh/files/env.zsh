export WGETRC="${XDG_CONFIG_HOME:-${HOME}/.config}/wgetrc"
echo hsts-file \= "${XDG_CONFIG_HOME:-${HOME}/.config}/wget-hsts" >> "${XDG_CONFIG_HOME:-${HOME}/.config}/wgetrc"
