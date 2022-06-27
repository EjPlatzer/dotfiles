let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

" Load vim-plug
set clipboard^=unnamed,unnamedplus
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set relativenumber

" Load plugins
call plug#begin(stdpath('config') . '/plugged')

Plug 'Mofiqul/dracula.nvim'

Plug 'tpope/vim-surround'

Plug 'chaoren/vim-wordmotion'

Plug 'dracula/vim',{'as':'dracula'}

call plug#end()

colorscheme dracula

