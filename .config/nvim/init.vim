set nocompatible              " be iMproved, required
filetype off                  " required


call plug#begin('~/.config/nvim/plugged')
    Plug 'chase/vim-ansible-yaml'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'tpope/vim-fugitive'
    Plug 'scrooloose/syntastic'
    Plug 'fatih/vim-go'
call plug#end()

filetype plugin indent on
syntax enable

set t_Co=256
colorscheme Tomorrow-Night


" general settings
set mouse=a
set backspace=indent,eol,start
set nobackup                        " Use vcs
set noswapfile                      " Use vcs
set grepprg=ack
set autoread
set relativenumber
let mapleader="\<space>"

" indenting
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent

" search/replace
set ignorecase
set smartcase
set incsearch
set hlsearch
set gdefault

" easier goto beginning/end of line
nnoremap <leader>a ^
nnoremap <leader>e $

" wildmenu
set wildmenu
set wildignore+=.hg,.git,.svn
set wildignore+=*.pyc

" airline
let g:airline_left_sep=''
let g:airline_right_sep=''
set laststatus=2

let python_highlight_all=1

" syntastic
let g:syntastic_check_on_open=1
let g:syntastic_quiet_messages={ "type": "style" }
let g:syntastic_python_checkers=["pylint"]
let g:syntastic_python_pylint_args="--disable=C,R0902,R0903,R0904,R0913,R0921,W0232,E1004,E1002"
