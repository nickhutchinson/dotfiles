" vim: fdm=marker:foldlevel=0:

" Bundle settings {{{
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle'

Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-obsession'
Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-rsi'
Plugin 'tpope/vim-sensible'    
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-vinegar'

Plugin 'nelstrom/vim-qargs'
Plugin 'nelstrom/vim-visual-star-search'

Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'chriskempson/base16-vim' 
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'edkolev/tmuxline.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'rhysd/vim-clang-format'
Plugin 'scrooloose/syntastic'
Plugin 'SirVer/ultisnips'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tomtom/tcomment_vim'
Plugin 'Valloric/YouCompleteMe'  

filetype plugin indent on     " required!

" }}}

" Colour scheme {{{
if $TERM_PROGRAM != "Apple_Terminal"
  let base16colorspace=256
endif
set background=dark
colorscheme base16-ocean
" }}}
" Options {{{
let mapleader = ","
set list
set hidden
set number
set hlsearch
set ignorecase
set smartcase
set colorcolumn=81
let &listchars="tab:▸ ,eol:¬"
set numberwidth=2
set noswapfile
set cursorline
set clipboard=unnamed
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set tags=./tags;
set mouse+=a
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif
"}}}
" Mappings{{{
" Easy way to exit insert mode
inoremap jj <Esc>

" Bubble lines
nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Splits {{{
nnoremap <leader>v :vnew<cr>
set splitbelow
set splitright
"}}}
"}}}

" CtrlP{{{
let g:ctrlp_root_markers = ['.ctrlp', '.project_root']
nnoremap <leader>B :CtrlPBuffer<CR>
nnoremap <leader>b :CtrlPBookmarkDir<CR>
nnoremap <leader>r :CtrlPMRUFiles<CR>
nnoremap <leader>cd :cd %:h<CR>
let g:ctrlp_clear_cache_on_exit = 0
"}}}
" YouCompleteMe{{{
let g:ycm_extra_conf_globlist = ["~/.ycm_extra_conf.py"]
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_path_to_python_interpreter = "/usr/bin/python"
nnoremap <leader><leader> :silent YcmCompleter GoTo<CR>
"}}}
" Airline{{{
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
"}}}
" UltiSnips{{{
let g:UltiSnipsExpandTrigger       = "<C-J>"
let g:UltiSnipsJumpForwardTrigger  = "<right>"
let g:UltiSnipsJumpBackwardTrigger = "<left>"
let g:snips_author                 = 'Nick Hutchinson'
let g:UltiSnipsSnippetDirectories  = ["UltiSnips"]
"}}}

" Misc
let g:delimitMate_expand_cr=1
nnoremap <leader>of :silent !open %:h<CR>
let &grepprg="ack -H --nocolor --nogroup --column"

" Filetype/indentation{{{
set ts=4 sts=4 sw=4 expandtab 
autocmd BufRead,BufNewFile *.m set filetype=objc
autocmd BufRead,BufNewFile *.mm set filetype=objcpp
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype lua setlocal ts=2 sts=2 sw=2
"}}}
" GUI Options{{{
set guioptions-=l
set guioptions-=r
set guioptions-=L
set guioptions-=R
set guicursor+=a:blinkon0
let &guifont="Inconsolata for Powerline:h15"
" Use console dialogs
set guioptions+=c
"}}}

" Folding
set foldmethod=syntax
set foldlevelstart=10
nnoremap <space> za

"Projectile {{{
let g:projectiles = {
   \ "*": {
   \   "*.m":  { "alternate": ["{}.h"] },
   \   "*.mm": { "alternate": ["{}.h"] },
   \   "*.c":  { "alternate": ["{}.h"] },
   \   "*.cc": { "alternate": ["{}.h", "{}.hpp"] },
   \   "*.cpp":{ "alternate": ["{}.h", "{}.hpp"] },
   \   "*.h":  { "alternate": ["{}.c", "{}.cc", "{}.cpp", "{}.m", "{}.mm"] },
   \   "*.hpp":{ "alternate": ["{}.cc", "{}.cpp"] },
   \ }
   \ }
"}}}
" Tagbar{{{
let g:tagbar_type_objc = {
    \ 'ctagstype' : 'ObjectiveC',
    \ 'kinds'     : [
        \ 'i:interface',
        \ 'I:implementation',
        \ 'p:Protocol',
        \ 'm:Object_method',
        \ 'c:Class_method',
        \ 'v:Global_variable',
        \ 'F:Object field',
        \ 'f:function',
        \ 'p:property',
        \ 't:type_alias',
        \ 's:type_structure',
        \ 'e:enumeration',
        \ 'M:preprocessor_macro',
    \ ],
    \ 'sro'        : ' ',
    \ 'kind2scope' : {
        \ 'i' : 'interface',
        \ 'I' : 'implementation',
        \ 'p' : 'Protocol',
        \ 's' : 'type_structure',
        \ 'e' : 'enumeration'
    \ },
    \ 'scope2kind' : {
        \ 'interface'      : 'i',
        \ 'implementation' : 'I',
        \ 'Protocol'       : 'p',
        \ 'type_structure' : 's',
        \ 'enumeration'    : 'e'
    \ }
\ }
"}}}

