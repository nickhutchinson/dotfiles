set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
filetype plugin indent on     " required!

Bundle 'tpope/vim-sensible'    
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-vinegar'
Bundle 'tpope/vim-projectile'

Bundle 'scrooloose/nerdcommenter'
Bundle 'Raimondi/delimitMate'  
Bundle 'chriskempson/base16-vim' 
Bundle 'Valloric/YouCompleteMe'  
Bundle 'rhysd/vim-clang-format'
Bundle 'bling/vim-airline'

Bundle 'nelstrom/vim-visual-star-search'
Bundle 'nelstrom/vim-qargs'
Bundle 'nelstrom/vim-mac-classic-theme'

Bundle 'majutsushi/tagbar'

Bundle 'amiorin/ctrlp-z'
Bundle 'kien/ctrlp.vim'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'msanders/snipmate.vim'
Bundle 'kana/vim-operator-user'

let mapleader = ","
set hidden
set number
set hlsearch
set background=dark
colorscheme base16-ocean

" Case insensitive search unless capital letter
set ignorecase
set smartcase

set guifont=Inconsolata\ For\ Powerline:h14
set colorcolumn=81

set listchars=tab:▸\ ,eol:¬

set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

 "Easy way to exit insert mode
inoremap jj <Esc>

" Use system clipboard
set clipboard=unnamed

" Bubble lines
nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [egv
vmap <C-Down> ]egv
  
set tags=./tags;

let g:ycm_path_to_python_interpreter = "/usr/bin/python"

let g:clang_format#command = "clang-format-3.4"

let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

nnoremap <C-_> <C-w>s<C-w>j
nnoremap <C-\> <C-w>v<C-w>l

" Disable MacVim scrollbars
set guioptions-=l
set guioptions-=r
set guioptions-=L
set guioptions-=R
"
" Use console dialogs
set guioptions+=c

let g:localvimrc_sandbox=0
let g:localvimrc_persistent=1

" Less annoying NERDCommenter mapping
nmap gcc <plug>NERDCommenterToggle
" need to map this also otherwise NERDCommenter doesn't bother
nmap <leader>c<space> <plug>NERDCommenterToggle
let g:delimitMate_expand_cr=1

autocmd Filetype c,cpp,objc,objcpp setlocal ts=2 sts=2 sw=2 expandtab 
autocmd BufRead,BufNewFile *.m set filetype=objc
autocmd BufRead,BufNewFile *.m. set filetype=objcpp

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*.d,*/CMakeFiles/*
let g:ctrlp_cmd = 'CtrlPLastMode'

set numberwidth=5

set noswapfile
