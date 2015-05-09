set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

Plugin 'mattn/emmet-vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'godlygeek/tabular'

call vundle#end()
filetype plugin indent on


" colorscheme for gui and terminal
if has("gui_running")
  set background=light
  colorscheme solarized

  set guioptions -=m     " remove menubar
  set guioptions -=T     " remove toolbar
else
  set background=dark
  colorscheme desert
endif
syntax enable

set guifont=Cousine\ 10
set encoding=utf-8

" tabs and spaces
set tabstop=4
set softtabstop=4
set expandtab


" ui options
set relativenumber
set cursorline
set scrolloff=3

set wildmenu

set showmatch

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=80


" leader etc.
let mapleader = ","

inoremap jj <esc>
nnoremap ; :

nnoremap <leader>s :mksession<CR>   " save session

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>


" search options
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch

set hlsearch
nnoremap <leader><space> :nohlsearch<CR>


" movement
nnoremap j gj
nnoremap k gk

nnoremap E $
nnoremap B ^


" autocommands
au FocusLost * :wa                    " save buffer when loosing focus
au BufWritePre * :%s/\s\+$//e         " remove trailing whitespaces


" tabularize extras
if exists(":Tabularize")
  nmap <Leader>1 :Tabularize /=<CR>
  vmap <Leader>1 :Tabularize /=<CR>
  nmap <Leader>2 :Tabularize /:<CR>
  vmap <Leader>2 :Tabularize /:<CR>
  nmap <Leader>3 :Tabularize /import<CR>
  vmap <Leader>3 :Tabularize /import<CR>
endif

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
