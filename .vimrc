" Basic setup

set nocompatible
set nobackup
set noswapfile
set number

syntax enable
filetype plugin on

" Finding files

set path+=**
set wildmenu

" Tag jumping

command! MakeTags !ctags -R -f ./.git/tags .
set tags+=./.git/tags;
set autochdir
