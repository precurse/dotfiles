" Components {
    call plug#begin('~/.config/nvim/plugged')
    " UI
    Plug 'romainl/flattened'
    Plug 'liuchengxu/vim-which-key'

    " Git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

    " Navigation
    Plug 'justinmk/vim-sneak'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'                 " fuzzy finder

    " Languages
    Plug 'plasticboy/vim-markdown',         { 'for': 'markdown' }
    Plug 'vim-latex/vim-latex',             { 'for': 'tex' }

    Plug 'tpope/vim-commentary'             " comment stuff out
    Plug 'tpope/vim-endwise'                " end structures
    Plug 'tpope/vim-sleuth'
    Plug 'alvan/vim-closetag'               " (X)HTML close tags
    Plug 'w0rp/ale'                         " async lint
    Plug 'sheerun/vim-polyglot'             " Language Pack
    Plug 'jiangmiao/auto-pairs'
    Plug 'jceb/vim-orgmode'

    call plug#end()
" }

" General {
    set noswapfile              " Use vcs
    set autoread                " Autoload file if it changes on disk

    set hidden                  " Allow buffer switching without saving

    set undofile                " So is persistent undo ...
    set undolevels=1000         " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload

    " vim-orgmode needs python
    let g:loaded_python3_provider = 1

    " Disable providers we do not give a shit about
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
    " default dark mode
    colorscheme flattened_dark
    set termguicolors

    function ToggleColors()
        if (g:colors_name == "flattened_dark")
            colorscheme flattened_light
        else
            colorscheme flattened_dark
        endif
    endfunction

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
    set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc  " MacOSX/Linux
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe     " Windows
    set scrolloff=5                 " Minimum lines to keep above and below cursor
    set sidescrolloff=5             " Minimum chars to keep left and right of cursor

" }

" Formatting {
    " indenting
    set tabstop=4
    set softtabstop=4
    set shiftwidth=0
    set expandtab
    "set autoindent
" }

" Key (re)Mapping {
    let mapleader="\<space>"
    let maplocalleader = ","

    " shortcut to toggle theme
    nnoremap <leader>B :call ToggleColors()<CR>

    " shotcuts to edit vimrc
    " from: https://www.cyberciti.biz/faq/how-to-reload-vimrc-file-without-restarting-vim-on-linux-unix/
    nnoremap <leader>ve :e $MYVIMRC<CR>
    nnoremap <leader>vr :source $MYVIMRC<CR>

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    "save current buffer
    nnoremap <leader>w :w<cr>
    nnoremap <leader>q :wq<cr>

    "replace the word under cursor
    nnoremap <leader>* :%s/\<<c-r><c-w>\>//g<left><left>

    " Most prefer to toggle search highlighting rather than clear the current search results.
    nmap <silent> <Leader>/ :set invhlsearch<CR>

    "move lines around
    nnoremap <leader>k :m-2<cr>==
    nnoremap <leader>j :m+<cr>==
    xnoremap <leader>k :m-2<cr>gv=gv
    xnoremap <leader>j :m'>+<cr>gv=gv

    " Quickly insert newlines without entering insert mode
    nnoremap <silent> <leader>o o<Esc>
    nnoremap <silent> <leader>O O<Esc>

    " Easy fold
    nnoremap <Leader><Space> za
" }

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
    " Languages {
    let g:vim_markdown_conceal = 0
    "}
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
    let g:fzf_buffers_jump = 1
    nnoremap <leader>fh :History<CR>
    nnoremap <leader>ff :Files<CR>
    nnoremap <leader>bb :Buffer<CR>
    nnoremap <leader>fs :Rg<CR>
    command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

    " auto-pairs
    let g:AutoPairsCenterLine=0
    let g:AutoPairsMultilineClose=0

    " WhichKey {
    let g:mapleader = "\<Space>"
    let g:maplocalleader = ','
    let g:which_key_use_floating_win = 1

    nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
    nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
    " }

" }
