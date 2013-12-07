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
Bundle 'elzr/vim-json'
Bundle 'kelan/gyp.vim'
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

" Sane backspace behaviour
set backspace=2

syntax on
set number
set hlsearch
set incsearch
set background=dark
colorscheme base16-solarized

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

if exists(":vscmd")
   map <C-I> :vscmd Tools.ClangFormat<CR>
   imap <C-I> <ESC>:vscmd Tools.ClangFormat<CR>i
end

"set list
set listchars=tab:▸\ ,eol:¬

set laststatus=2 " Always display the statusline in all windows
set noshowmode " Hie the default mode text (e.g. -- INSERT -- below the statusline)

cmap w!! w !sudo tee > /dev/null %
inoremap jj <Esc>
set clipboard=unnamed
set timeoutlen=200

inoremap <Left>  <NOP>
inoremap <Right> <NOP>
inoremap <Up>    <NOP>
inoremap <Down>  <NOP>

