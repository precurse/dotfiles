filetype off

call plug#begin('~/.config/nvim/plugged')
    Plug 'junegunn/seoul256.vim'            " colour/theme
    Plug 'tpope/vim-commentary'             " comment stuff out
    Plug 'vim-airline/vim-airline'          " status/tabline
    Plug 'vim-airline/vim-airline-themes'   " themes
    Plug 'tpope/vim-fugitive'               " git wrapper
    Plug 'w0rp/ale'                         " async lint
    Plug 'fatih/vim-go'                     " go development
    Plug 'sheerun/vim-polyglot'             " Language Pack
    Plug 'airblade/vim-gitgutter'           " Git diff
    Plug 'Valloric/YouCompleteMe'           " auto-complete
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
call plug#end()

filetype plugin indent on
syntax enable

colo seoul256
set background=dark

" general settings
set mouse=
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
highlight TrailSpace ctermbg=darkred
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

" ctrlp
nnoremap <leader>f :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>t :CtrlPBufTag<CR>
nnoremap <leader>T :CtrlPTag<CR>
let g:ctrlp_show_hidden=1
let g:ctrlp_extensions=['tag', 'buffertag']
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" airline
let g:airline_left_sep=''
let g:airline_right_sep=''
set laststatus=2

" syntastic
let g:syntastic_check_on_open=1
let g:syntastic_quiet_messages={ "type": "style" }
let g:syntastic_python_checkers=["pylint"]
let g:syntastic_python_pylint_args="--disable=C,R0902,R0903,R0904,R0913,R0921,W0232,E1004,E1002"
