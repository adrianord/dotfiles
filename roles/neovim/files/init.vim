runtime shared/init.vim
if exists('g:vscode')
  runtime vscode/init.vim
else
  runtime vim/init.vim
  set tabstop=4
  set shiftwidth=4
  set expandtab
endif
