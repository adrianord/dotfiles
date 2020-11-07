"------------------- Bootstrap Vim-Plug -------------------"
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs 
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

"------------------- Activate Plugins -------------------"
let pluginsPath = stdpath('data') . '/plugged'
call plug#begin(pluginsPath)

Plug 'takac/vim-hardtime'

call plug#end()
unlet pluginsPath

"------------------- Install Missing Plugins -------------------"
if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

runtime shared/init.vim
if exists('g:vscode')
  runtime vscode/init.vim
else
  runtime vim/init.vim
endif
