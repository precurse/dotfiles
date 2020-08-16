" Components {
    call plug#begin('~/.config/nvim/plugged')
    " UI
    Plug 'romainl/flattened'

    " Git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

    " Languages

    Plug 'tpope/vim-commentary'             " comment stuff out
    Plug 'tpope/vim-endwise'                " end structures
    Plug 'tpope/vim-sleuth'
    Plug 'alvan/vim-closetag'               " (X)HTML close tags
    Plug 'w0rp/ale'                         " async lint
    Plug 'sheerun/vim-polyglot'             " Language Pack
    Plug 'jiangmiao/auto-pairs'
    Plug 'junegunn/fzf.vim'                 " fuzzy finder

    call plug#end()
" }

" General {
    set mouse=                          " Disable mouse
    set backspace=indent,eol,start
    set noswapfile                      " Use vcs
    set grepprg=ack
    set autoread
    let mapleader="\<space>"

    set undofile                " So is persistent undo ...
    set undolevels=1000         " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload

    " Disable providers we do not give a shit about
    let g:loaded_python3_provider = 0
    let g:loaded_python_provider = 0
    let g:loaded_ruby_provider = 0
    let g:loaded_perl_provider = 0
    let g:loaded_node_provider = 0

    " Disable some in built plugins completely
    let g:loaded_netrw            = 1
    let g:loaded_netrwPlugin      = 1
    let g:loaded_matchparen       = 1
    let g:loaded_matchit          = 1
    let g:loaded_2html_plugin     = 1
    let g:loaded_getscriptPlugin  = 1
    let g:loaded_gzip             = 1
    let g:loaded_logipat          = 1
    let g:loaded_rrhelper         = 1
    let g:loaded_spellfile_plugin = 1
    let g:loaded_tarPlugin        = 1
    let g:loaded_vimballPlugin    = 1
    let g:loaded_zipPlugin        = 1
" }

" UI {
    colorscheme flattened_dark
    set termguicolors

    function ToggleColors()
        if (g:colors_name == "flattened_dark")
            colorscheme flattened_light
        else
            colorscheme flattened_dark
        endif
    endfunction

    " shortcut to toggle 
    nnoremap <C-b> :call ToggleColors()<CR>

    " Broken down into easily includeable segments
    set laststatus=2
    set statusline=
    set statusline+=%<%f\                              " Filename
    set statusline+=%w%h%m%r%q                         " Options
    set statusline+=%{fugitive#statusline()}           " Git Hotness
    set statusline+=[%{strlen(&fenc)?&fenc:&enc}/%Y] " Filetype
    set statusline+=[%{SleuthIndicator()}]
    set statusline+=%*
    set statusline+=%=%-14.(%l,%c%V%) "\ %p%%" Right aligned file nav info

    set showcmd
    set showmatch
    set hlsearch
    set incsearch
    set ignorecase
    set smartcase
    set wildignore+=.hg,.git,.svn
    set wildignore+=*.pyc

" }


"save current buffer
nnoremap <leader>w :w<cr>

"replace the word under cursor
nnoremap <leader>* :%s/\<<c-r><c-w>\>//g<left><left>

"move lines around
nnoremap <leader>k :m-2<cr>==
nnoremap <leader>j :m+<cr>==
xnoremap <leader>k :m-2<cr>gv=gv
xnoremap <leader>j :m'>+<cr>gv=gv

" indenting
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent

" search/replace
set gdefault

" highlight whitespace
highlight TrailSpace ctermbg=darkred
match TrailSpace / \+$/

" clear highlighting and redraw
nnoremap <silent> <leader>l :nohl<CR><C-l>

" split navigation
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Plugins {
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

    " fzf
    nnoremap <leader>f :Files<CR>
    nnoremap <leader>b :Buffer<CR>
    nnoremap <leader>t :BTags<CR>
    nnoremap <leader>T :Tag<CR>
    let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'

    " auto-pairs
    let g:AutoPairsCenterLine=0
    let g:AutoPairsMultilineClose=0

" }
