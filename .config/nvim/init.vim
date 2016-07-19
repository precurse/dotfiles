call plug#begin('~/.config/nvim/plugged')
    Plug 'junegunn/seoul256.vim'
    Plug 'tpope/vim-commentary'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'tpope/vim-fugitive'
    Plug 'scrooloose/syntastic'
    Plug 'fatih/vim-go'
    Plug 'pearofducks/ansible-vim'
call plug#end()

filetype plugin indent on
syntax enable

colo seoul256
set background=dark

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

" whitespace
highlight TrailSpace guibg=red ctermbg=darkred
match TrailSpace / \+$/

" easier goto beginning/end of line
nnoremap <leader>a ^
nnoremap <leader>e $

" clear highlighting and redraw
nnoremap <silent> <leader>l :nohl<CR><C-l>

" split navigation
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l


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
