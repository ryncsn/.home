set nocompatible

syntax on
filetype off

" Default configs
syntax on
set hlsearch
set incsearch
set showmatch

" Colored Indent
let g:indent_guides_enable_on_vim_startup = 1

" Search for ctag mark file until reach /
set tags=tags;

" Tag bar show symbols in file order, and always on unless vimdiff
if !&diff
	let g:tagbar_sort = 0
	autocmd FileType * :call tagbar#autoopen(0)
endif

" Show hidden/tailing/heading characters
set list
set listchars=tab:•\ ,trail:·,extends:❯,precedes:❮,nbsp:×
set statusline=%F%m%r%h%w\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2

" No swp file
set noswapfile

" For MacOS (Be compatible with GNU/Linux)
set backspace=indent,eol,start

set spell
