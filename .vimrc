set nocompatible

filetype off
"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" YCM
Plugin 'Valloric/YouCompleteMe'

" Deps
Plugin 'tomtom/tlib_vim'
Plugin 'MarcWeber/vim-addon-mw-utils'

" Snips
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Bundle 'chrisgillis/vim-bootstrap3-snippets'

"Javascript indent
Plugin 'pangloss/vim-javascript'

"Javascript highlight
Plugin 'jelera/vim-javascript-syntax'

"Python indent
"Plugin 'vim-scripts/indentpython.vim'
Plugin 'hynek/vim-python-pep8-indent'

"Auto quotes, parens, brackets etc.
"Plugin 'Raimondi/delimitMate'

"Airline
Plugin 'bling/vim-airline'
"Powerline
"Plugin 'powerline/powerline'

"Color
Plugin 'nanotech/jellybeans.vim'

"Nerd Tree
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'Xuyuanp/nerdtree-git-plugin'

"CtrlP
Plugin 'kien/ctrlp.vim'

"Better HTML
Plugin 'othree/html5.vim'

"Misc Syntax check
Plugin 'scrooloose/syntastic'

" Text align
Plugin 'godlygeek/tabular'

" Surrounding
Plugin 'tpope/vim-surround'

" Colored indent
Plugin 'nathanaelkane/vim-indent-guides'

" Jade support
Plugin 'digitaltoad/vim-jade'

" Php autocompletion
Plugin 'shawncplus/phpcomplete.vim'
" Php Color
Plugin 'StanAngeloff/php.vim'
" Php syntax check
Plugin 'joonty/vim-phpqa'

" Show redanunt spaces
Plugin 'bitc/vim-bad-whitespace'

"Plugin '2072/PHP-Indenting-for-VIm'
"Plugin 'lukaszb/vim-web-indent'
"Plugin 'tpope/vim-fugitive'
"Plugin 'moll/vim-node'
"Plugin 'guileen/vim-node-dict'
"Plugin 'ahayman/vim-nodejs-complete'


"Broken

"Use YCM Instead
"Plugin 'davidhalter/jedi'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
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

inoremap <expr> <C-j> ((pumvisible())?("\<Down>"):("j"))
inoremap <expr> <C-k> ((pumvisible())?("\<Up>"):("k"))

nmap <F4> :YcmDiags<CR>

let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
let g:ycm_confirm_extra_conf=0
let g:ycm_collect_indentifiers_from_tags_files=1
let g:ycm_min_num_of_chars_for_completion=1
let g:ycm_seed_indentifiers_with_syntax=1
let g:ycm_complete_in_comments=1
let g:ycm_complete_in_strings=1

let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsListSnippets = "<C-n>"
let g:UltiSnipsJumpForwardTrigger = "<Down>"
let g:UltiSnipsJumpBackwardTrigger = "<Up>"
let g:UltiSnipsEditSplit="vertical"

" vim-airline config
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
set laststatus=2

" Bootstrap auto complete
set dictionary+=~/.vim/bundle/bootstrap-snippets/dictionary
set complete+=k

"Nerd tree
nnoremap <C-n> :NERDTreeToggle<CR>
let g:nerdtree_tabs_autofind = 1
let NERDTreeShowBookmarks=1

"Buffer jump
map <F5> :buffers<CR>:buffer<Space>

" Default
syntax on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set hlsearch
set expandtab
set incsearch
set showmatch
set smartindent
colorscheme jellybeans

"Check syntax
let g:syntastic_check_on_open=1
let g:syntastic_javascript_checkers = ['jshint']


"Colored Indent
let g:indent_guides_enable_on_vim_startup = 1

" HTML style indent
autocmd FileType jade,javascript,html,css,php set tabstop=2 shiftwidth=2 softtabstop=2

" WEB autocompletion
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" PHP autocompletion
au BufRead,BufNewFile *.php set ft=php.javascript.html.css

autocmd FileType c,cpp set expandtab!

let g:phpcomplete_complete_for_unknown_classes = 1
let g:phpcomplete_search_tags_for_variables = 1
let g:phpcomplete_relax_static_constraint = 1
let g:phpcomplete_cache_taglists = 1
let g:phpcomplete_enhance_jump_to_definition = 1

" Javascript
let javascript_enable_domhtmlcss = 1

let g:airline_powerline_fonts = 1


"GUI Part
set guifont=Hack\ 12

