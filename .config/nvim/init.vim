filetype off

call plug#begin('~/.config/nvim/plugged')
    Plug 'junegunn/seoul256.vim'            " colour/theme
    Plug 'tpope/vim-commentary'             " comment stuff out
    Plug 'tpope/vim-fugitive'               " git wrapper
    Plug 'vim-airline/vim-airline'          " status/tabline
    Plug 'vim-airline/vim-airline-themes'   " themes
    Plug 'w0rp/ale'                         " async lint
    Plug 'fatih/vim-go'                     " go development
    Plug 'sheerun/vim-polyglot'             " Language Pack
    Plug 'airblade/vim-gitgutter'           " Git diff
    Plug 'Valloric/YouCompleteMe'           " auto-complete
    Plug 'jiangmiao/auto-pairs'
    Plug 'junegunn/fzf.vim'                 " fuzzy finder
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
call plug#end()

filetype plugin indent on
syntax enable

colo seoul256
set background=dark

" general settings
set mouse=                          " Disable mouse
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

" highlight whitespace
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
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>t :BTags<CR>
nnoremap <leader>T :Tags<CR>

" airline
let g:airline_left_sep=''
let g:airline_right_sep=''
set laststatus=2
