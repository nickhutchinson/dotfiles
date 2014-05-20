" Bundle settings {{{
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
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

Plugin 'nelstrom/vim-qargs'
Plugin 'nelstrom/vim-visual-star-search'

" Battle of the file managers
" Plugin 'tpope/vim-vinegar'
Plugin 'dhruvasagar/vim-vinegar'
Plugin 'scrooloose/nerdtree'

Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'bufkill.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'edkolev/tmuxline.vim'
Plugin 'godlygeek/tabular'
Plugin 'JazzCore/ctrlp-cmatcher'
Plugin 'justinmk/vim-sneak'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'maxbrunsfeld/vim-yankstack'
Plugin 'PeterRincker/vim-argumentative'
Plugin 'rhysd/vim-clang-format'
Plugin 'scrooloose/syntastic'
Plugin 'SirVer/ultisnips'
Plugin 'sjl/gundo.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tomtom/tcomment_vim'
Plugin 'Valloric/YouCompleteMe'

call vundle#end()            " required
filetype plugin indent on    " required
" }}}

" Colour scheme {{{
if $TERM_PROGRAM != "Apple_Terminal"
  let base16colorspace=256
endif
set background=dark
colorscheme base16-ocean
highlight MatchParen ctermbg=4
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
let &listchars='tab:▸ ,eol:¬,trail:▓'
let &showbreak='↪ '
set numberwidth=2
set noswapfile
set cursorline
set clipboard=unnamed,unnamedplus
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set tags=./.tags;
set splitbelow
set splitright
set spelllang=en_gb
set shell=bash
set confirm  " friendly confirm dialogs

set mouse+=a
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

set undofile
set undodir=~/.vim/cache/
"}}}

" Mappings{{{
" Easy way to exit insert mode
inoremap jj <Esc>

" Bubble lines
nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [egv
vmap <C-Down> ]egv
"}}}
" Netrw/NERDTree"{{{
nnoremap <silent> <leader>n :NERDTreeToggle<CR>
nnoremap <silent> <leader>N :NERDTreeFind<CR>
let g:NERDTreeShowBookmarks=1

let g:NERDTreeIgnore = [
    \   '^out$[[dir]]',
    \   '^objects$[[dir]]',
    \   '\v\.(dll|lib|so)$[[file]]'
    \ ]

let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v/(out|objects)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ }
"}}}
" CtrlP{{{
let g:ctrlp_root_markers = ['.ctrlp', '.project_root']
nnoremap <leader>t :CtrlPBufTagAll<CR>
nnoremap <leader>b :CtrlPBookmarkDir<CR>
nnoremap <leader>r :CtrlPMRUFiles<CR>
nnoremap <leader>cd :lcd %:h<CR>
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_match_func  = {'match' : 'matcher#cmatch'}
let g:ctrlp_max_files=100000
let g:ctrlp_cmd = 'CtrlPMixed'
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
let g:airline#extensions#tabline#buffer_nr_show = 1
"}}}
" UltiSnips{{{
let g:UltiSnipsExpandTrigger       = "<C-J>"
let g:UltiSnipsJumpForwardTrigger  = "<right>"
let g:UltiSnipsJumpBackwardTrigger = "<left>"
let g:snips_author                 = 'Nick Hutchinson'
let g:UltiSnipsSnippetDirectories  = ["UltiSnips"]
"}}}
"Sneak{{{
let g:sneak#s_next = 1
let g:gneak#streak = 1
"}}}
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
if has("mac")
    let &guifont="Inconsolata for Powerline:h15"
endif
" Use console dialogs
set guioptions+=c
"}}}
" Folding"{{{
set foldmethod=syntax
set foldlevelstart=10
nnoremap <space> za
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
" Projectile"{{{
let g:projectiles = {
   \ "*": {
   \   "*.m":  { "alternate": ["{}.h"] },
   \   "*.mm": { "alternate": ["{}.h"] },
   \   "*.c":  { "alternate": ["{}.h"] },
   \   "*.cc": { "alternate": ["{}.h"] },
   \   "*.cpp":{ "alternate": ["{}.h"] },
   \   "*.h":  { "alternate": ["{}.c", "{}.cc", "{}.cpp", "{}.m", "{}.mm"] }
   \ },
   \ "src/&include/": {
   \   "include/*.h": {"alternate": ["src/{}.cpp"]},
   \   "src/*.cpp": {"alternate": ["include/{}.h"]}
   \ }
   \ }
"}}}
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" vim: fdm=marker:foldlevel=0:
