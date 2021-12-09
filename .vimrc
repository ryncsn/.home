set shell=/bin/bash
set nocompatible

syntax on
filetype off

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Fish shell
Plugin 'dag/vim-fish'

" YCM
Plugin 'Valloric/YouCompleteMe'

" Snips
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

"Python indent
Plugin 'hynek/vim-python-pep8-indent'

"Auto quotes, parens, brackets etc.
Plugin 'Raimondi/delimitMate'

"Airline
Plugin 'bling/vim-airline'

"Color
Plugin 'nanotech/jellybeans.vim'

"Better HTML
Plugin 'othree/html5.vim'

" Surrounding
Plugin 'tpope/vim-surround'

" Colored indent
Plugin 'nathanaelkane/vim-indent-guides'

" Jade support
Plugin 'digitaltoad/vim-jade'

" Show redanunt spaces
Plugin 'bitc/vim-bad-whitespace'

" Vue
Plugin 'posva/vim-vue'

" typescript
Plugin 'leafgarland/typescript-vim'
Plugin 'Quramy/tsuquyomi'
Plugin 'Shougo/vimproc.vim'

" Syntax Check
Plugin 'w0rp/ale'

" Rust
Plugin 'rust-lang/rust.vim'

" Auto indent
Plugin 'tpope/vim-sleuth'

" Tagbar
Plugin 'majutsushi/tagbar'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ

let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
let g:ycm_confirm_extra_conf=0
let g:ycm_collect_indentifiers_from_tags_files=1
let g:ycm_min_num_of_chars_for_completion=1
let g:ycm_seed_indentifiers_with_syntax=1
let g:ycm_complete_in_comments=1
let g:ycm_complete_in_strings=1
let g:ycm_max_diagnostics_to_display = 4096

let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsEditSplit="vertical"

" vim-airline config
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1

" Buffer jump
nmap <F5> :buffers<CR>:buffer<Space>
nmap <F8> :TagbarToggle<CR>

" Default configs
syntax on
set hlsearch
set incsearch
set showmatch

" I Like this color
colorscheme jellybeans

" Colored Indent
let g:indent_guides_enable_on_vim_startup = 1

" Enable ale linters
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python': ['flake8'],
\   'rust': ['cargo'],
\}

" WEB autocompletion
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" Javascript
let javascript_enable_domhtmlcss = 1

" Search for ctag mark file until reach /
set tags=tags;

" Tag bar show symbols in file order, and always on
let g:tagbar_sort = 0
autocmd FileType * :call tagbar#autoopen(0)

" Show hidden/tailing/heading characters
set list
set listchars=tab:•\ ,trail:·,extends:❯,precedes:❮,nbsp:×

" For MacOS (Be compatible with GNU/Linux)
set backspace=indent,eol,start
