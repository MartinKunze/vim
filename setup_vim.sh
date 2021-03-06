#!/bin/bash

echo "Remove old Vundel installations"
test -d ~/.vim/bundle/Vundle.vim && rm -rf ~/.vim/bundle/Vundle.vim

echo "Install Vundle"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "Backup old vim.rc to > vim.rc_bac"
> ~/.vimrc

echo "Create New VIM File"
cat << EOF > ~/.vimrc
set nocompatible                        " Using vim not vi

filetype plugin indent on
syntax on

" Basics {{{
set backspace=indent,eol,start
set smartindent
set tabstop=2
set softtabstop=2
set smarttab
set shiftwidth=2
autocmd FileType *.yaml *. yml set tabstop=2|set shiftwidth=2|set softtabstop=2
set noexpandtab
set encoding=utf-8
set number                              " Show linenumbers
set showcmd                             " Show info in the right bottom
set ttyfast
set textwidth=80
set colorcolumn=+1                      " Display margin at 81
set t_Co=256
set nocursorline                        " Do not hightlight the current line
set scrolloff=5
set sidescroll=1
set sidescrolloff=10
set formatoptions=qcrn1
set pastetoggle=<F8>
set novisualbell                        " No blinking .
set noerrorbells                        " No noise.
set lazyredraw
set autoread                            " Reload file if it's modified outside
set autowrite
set autoindent
set ruler                               " Show line and column number
set showbreak=↪
set title
set wrap								" long text with breackline
set linebreak
set nolist								" Change to list to enable listchars
set pfn=:h8
set penc="cp1252"
let mapleader = " "
set wildignore+=*.pyc,*.swp,*.pdf,*.class
let g:ctrlp_custom_ignore = {
    \ 'dir':  'out$\|\.git$\|\.data$\|bower_components$\|node_modules$\|vendor',
	\ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$\|\DS_Store$',
	\ }
set guifont=Menlo:h12
" }}}

" Backups {{{
" set backupskip=/tmp/*,/private/tmp/*"
"set undodir=~/.vim/tmp/undo//
"set backupdir=~/.vim/tmp/backup//
"set directory=~/.vim/tmp/swap//
"set backup
"set noswapfile
" }}}
" GUI & Terminal settings {{{
if has("gui_running")
	set guioptions= " disable all UI options
	set guicursor+=a:blinkon0 " disable blinking cursor
	set ballooneval
endif
" }}}

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
set runtimepath^=~/.vim/bundle/ctrlp.vim
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required

"Themes {{{
Plugin 'jorgechato/vim-youcolor'
Plugin 'jorgechato/vim-blacktie'
Plugin 'flazz/vim-colorschemes'
"Plugin 'endel/vim-github-colorscheme'
"}}}

Plugin 'danro/rename.vim'
Plugin 'mattn/emmet-vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ervandew/supertab'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'easymotion/vim-easymotion'
Plugin 'kshenoy/vim-signature'
Plugin 'tell-k/vim-autopep8'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'cjrh/vim-conda'
Plugin 'rizzatti/dash.vim'
Plugin 'mileszs/ack.vim'
Plugin 'terryma/vim-multiple-cursors'

"syntax
Plugin 'vim-syntastic/syntastic'
Plugin 'elixir-editors/vim-elixir'
Plugin 'keith/swift.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'elzr/vim-json'
Plugin 'LaTeX-Box-Team/LaTeX-Box'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'Shutnik/jshint2.vim'
Plugin 'plasticboy/vim-markdown'
Plugin 'avakhov/vim-yaml'
Plugin 'fatih/vim-go'
Plugin 'modille/groovy.vim'
Plugin 'hashivim/vim-terraform'
Plugin 'juliosueiras/vim-terraform-completion'
Plugin 'chr4/nginx.vim'
Plugin 'posva/vim-vue'
Plugin 'othree/html5.vim'
Plugin 'jparise/vim-graphql'
Plugin 'derekwyatt/vim-scala'
Plugin 'dart-lang/dart-vim-plugin'

" Initialize plugin system
call vundle#end()            " required
filetype plugin indent on    " required

" Pluginin settings --------------------------------------------------------- {{{
" vue {{{
au BufRead,BufNewFile *.vue set filetype=vue.html
" }}}
" swift {{{
let g:syntastic_swift_swiftlint_use_defaults = 1
" }}}
" terraform {{{
let g:terraform_align=1
let g:syntastic_terraform_tffilter_plan = 1
let g:terraform_completion_keys = 1
let g:terraform_registry_module_completion = 0
" }}}
" editorconfig {{{
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
" }}}
" ack to ag {{{
let g:ackprg = 'ag --vimgrep'
" }}}
" syntastic {{{
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_swift_checkers = ['swiftlint', 'swiftpm']
" }}}
" Python jedi {{{
let g:jedi#popup_on_dot = 0
let g:deoplete#sources#jedi#python_path = '$HOME/miniconda3/bin/python3.6'
autocmd FileType python setlocal completeopt-=preview
" }}}
" Python autopep8 {{{
let g:autopep8_disable_show_diff=1
autocmd FileType python set equalprg=autopep8\ -
autocmd FileType python autocmd BufWritePre <buffer> call Autopep8()
" }}}
"airline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 0
if has("gui_running")
	let g:airline_theme='lucius'
else
	let g:airline_theme='term'
	if !exists('g:airline_symbols')
		let g:airline_symbols = {}
	endif
	let g:airline_powerline_fonts = 1
endif
" }}}
" Latex {{{
let s:extfname = expand("%:e")
if s:extfname ==? "tex"
	let g:LatexBox_split_type="new"
endif
" }}}
" jshint2 {{{
set runtimepath+=$HOME/.vim/plugged/jshint2.vim/
" }}}
" nerdcommenter {{{
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" }}}
" }}}

" Color scheme ------------------------------------------------------------ {{{
let g:solarized_termcolors=256
syntax enable                           " Switch syntax highlighting on
" }}}

" Custom functions -------------------------------------------------------- {{{
" Twiddle Case {{{
function! TwiddleCase(str)
	if a:str ==# toupper(a:str)
		let result = tolower(a:str)
	elseif a:str ==# tolower(a:str)
		let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
	else
		let result = toupper(a:str)
	endif
	return result
endfunction
" }}}

" }}}

" Custom interface -------------------------------------------------------- {{{
set cursorline
set hlsearch

" colorscheme blacktie
colorscheme github

"interface {{{
hi Search cterm=underline
" }}}
" }}}

" Language ---------------------------------------------------------------- {{{
set spell spelllang=en_us
"set nospell
" }}}

" Mappings ---------------------------------------------------------------- {{{
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv
nnoremap <leader>+ :set gfn=*<CR>
nnoremap <leader>t :bnext<CR>
nnoremap <leader>w :bd<CR>
map <F7> mzgg=G'zmz
map <F8> <leader>cc
map <F9> <leader>cu
map <leader>p <esc>:CtrlPBuffer<CR>
map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>a
inoremap <F2> <C-O>za
nnoremap <F2> za
nnoremap <F3> zR
onoremap <F2> <C-C>za
vnoremap <F3> zf
nnoremap td  :tabclose<CR>
nnoremap tn :tabnew<CR>
nn <F6> :setlocal spell! spell?<CR>
nnoremap cou :set nonumber!<CR>
vmap <leader>2 gj
vmap <leader>8 gk
vmap <leader>6 g$
vmap <leader>4 g^
nmap <leader>2 gj
nmap <leader>8 gk
nmap <leader>6 g$
nmap <leader>4 g^
map <Leader>f <Plugin>(easymotion-sn)
omap <Leader>f <Plugin>(easymotion-tn)
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
" For local replace
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>
" For global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>
"Pretty tab
nmap <Leader>t= :Tabularize /=<CR>
vmap <Leader>t= :Tabularize /=<CR>
nmap <Leader>t: :Tabularize /:\zs<CR>
vmap <Leader>t: :Tabularize /:\zs<CR>
" fugitive git bindings
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gt :Gcommit -v -q %:p<CR>
nnoremap <leader>gd :Gdiff<Space>
nnoremap <leader>ge :Gedit<Space>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gp :Git push origin <Space>
nnoremap <leader>g- :Silent Git stash<CR>:e<CR>
nnoremap <leader>g+ :Silent Git stash pop<CR>:e<CR>
nnoremap <leader>gB :Gblame<CR>
nnoremap <leader>gg :Ggrep<Space>
nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>gb :Git branch<Space>
nnoremap <leader>gsw :Git switch<Space>
nnoremap <leader>gl :silent! Glog<CR>:bot copen<CR>
" }}}

" Fold -------------------------------------------------------------------- {{{
set foldmethod=syntax
set nofoldenable

let javaScript_fold=1         " JavaScript
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML
" }}}
EOF

echo "Install Plugins"
vim +PluginInstall +qall
