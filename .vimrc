set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
filetype plugin indent on     " required!

" List plugins and stuff here
Bundle 'chriskempson/base16-vim'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/syntastic'
Bundle 'editorconfig/editorconfig-vim'

" Sane backspace behaviour
set backspace=2

syntax on
set number
set hlsearch
set incsearch
set background=dark
colorscheme base16-tomorrow

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Case insensitive unless capital letter
set ignorecase
set smartcase

set guifont=Inconsolata:h15
set shell=bash
set colorcolumn=80

map <C-I> :pyf ~/.vim/clang-format.py<CR>
imap <C-I> <ESC>:pyf ~/.vim/clang-format.py<CR>i

if has(":vscmd")
   map <C-I> :vscmd Tools.ClangFormat<CR>
   imap <C-I> <ESC>:vscmd Tools.ClangFormat<CR>i
end
