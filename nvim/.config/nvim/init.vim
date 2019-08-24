filetype off

call plug#begin('~/.config/nvim/plugged')
    Plug 'tpope/vim-commentary'             " comment stuff out
    Plug 'tpope/vim-fugitive'               " git wrapper
    Plug 'tpope/vim-endwise'                " end structures
    Plug 'alvan/vim-closetag'               " (X)HTML close tags
    Plug 'vim-airline/vim-airline'          " status/tabline
    Plug 'vim-airline/vim-airline-themes'   " themes
    Plug 'w0rp/ale'                         " async lint
    Plug 'fatih/vim-go'                     " go development
    Plug 'sheerun/vim-polyglot'             " Language Pack
    Plug 'airblade/vim-gitgutter'           " Git diff
    Plug 'Valloric/YouCompleteMe'           " auto-complete
    Plug 'jiangmiao/auto-pairs'
    Plug 'ctrlpvim/ctrlp.vim'               " fuzzy finder
    Plug 'diepm/vim-rest-console'
    Plug 'zeek/vim-zeek'
call plug#end()

filetype plugin indent on
syntax enable

" colorscheme
set t_Co=256
colorscheme Tomorrow-Night

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

" fugitive
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>ge :Gedit<CR>

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

" auto-pairs
let g:AutoPairsCenterLine=0
let g:AutoPairsMultilineClose=0
