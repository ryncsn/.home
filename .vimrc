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

" Both YCM and ALE for autocomplete and lint
Plugin 'Valloric/YouCompleteMe'
Plugin 'w0rp/ale'

"Airline
Plugin 'vim-airline/vim-airline'

"Color
Plugin 'nanotech/jellybeans.vim'

"Auto quotes, parens, brackets etc.
Plugin 'Raimondi/delimitMate'

"Rainbow parens
Plugin 'luochen1990/rainbow'

"Snips
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" Surrounding
Plugin 'tpope/vim-surround'

" Colored indent
Plugin 'nathanaelkane/vim-indent-guides'

" Show redanunt spaces
Plugin 'bitc/vim-bad-whitespace'

" Auto indent
Plugin 'tpope/vim-sleuth'

" Tagbar
Plugin 'majutsushi/tagbar'

"Python indent
Plugin 'hynek/vim-python-pep8-indent'

"Better HTML
Plugin 'othree/html5.vim'

"Fish shell support
Plugin 'dag/vim-fish'

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

" Use YCM for C, Python and some other lang auto complete and syntax check
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
let g:ycm_confirm_extra_conf=0
let g:ycm_min_num_of_chars_for_completion=1
let g:ycm_seed_indentifiers_with_syntax=1
let g:ycm_complete_in_comments=1
let g:ycm_complete_in_strings=1
let g:ycm_max_diagnostics_to_display = 4096

let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']

nnoremap gl :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap g<S-g> :YcmCompleter GoTo<CR>

" Disable ALE for C
autocmd BufEnter *.c ALEDisable
autocmd BufEnter *.h ALEDisable

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

" rainbow parentheses
let g:rainbow_active = 1

" Buffer jump
nmap <F5> :buffers<CR>:buffer<Space>
nmap <F8> :TagbarToggle<CR>
nnoremap <C-]> g<C-]>

" Default configs
syntax on
set hlsearch
set incsearch
set showmatch

" I Like this color
colorscheme jellybeans

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
