set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
filetype plugin indent on     " required!

" List plugins and stuff here

" sane set of defaults
Bundle 'tpope/vim-sensible'    
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-commentary'  
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-dispatch'

Bundle 'Raimondi/delimitMate'  
Bundle 'chriskempson/base16-vim' 
Bundle 'Valloric/YouCompleteMe'  
Bundle 'rhysd/vim-clang-format'
Bundle 'editorconfig/editorconfig-vim'
Bundle 'bling/vim-airline'
Bundle 'nelstrom/vim-visual-star-search'
Bundle 'nelstrom/vim-qargs'
Bundle 'majutsushi/tagbar'
Bundle 'kien/ctrlp.vim'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'scrooloose/nerdtree'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'msanders/snipmate.vim'

set hidden
set number
set hlsearch
set background=dark
colorscheme base16-tomorrow

" Case insensitive unless capital letter
set ignorecase
set smartcase

set guifont=Inconsolata\ For\ Powerline:h15
set colorcolumn=81

set listchars=tab:▸\ ,eol:¬

set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" Easy way to exit insert mode
inoremap jj <Esc>
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

