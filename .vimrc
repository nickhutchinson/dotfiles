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
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'

Plugin 'airblade/vim-gitgutter'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'bling/vim-airline'
Plugin 'bufkill.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'dhruvasagar/vim-vinegar'
Plugin 'edkolev/tmuxline.vim'
Plugin 'godlygeek/tabular'
Plugin 'honza/vim-snippets'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'ivalkeen/vim-ctrlp-tjump'
Plugin 'JazzCore/ctrlp-cmatcher'
Plugin 'jpalardy/vim-slime'
Plugin 'justinmk/vim-sneak'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'maxbrunsfeld/vim-yankstack'
Plugin 'mhinz/vim-startify'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'nelstrom/vim-qargs'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'PeterRincker/vim-argumentative'
Plugin 'rhysd/vim-clang-format'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'SirVer/ultisnips'
Plugin 'sjl/gundo.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tomtom/tcomment_vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'wellle/targets.vim'

call vundle#end()            " required
filetype plugin indent on    " required
" }}}

" Colour scheme {{{
if $TERM_PROGRAM != "Apple_Terminal"
  let base16colorspace=256
endif
set background=dark
colorscheme base16-solarized
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
set undofile
set undodir=/tmp

set mouse+=a
if &term =~ '^screen'
  " tmux knows the extended mouse mode
  set ttymouse=xterm2
endif

if has("mac")
  set macmeta
endif

"}}}

" Mappings{{{
" Easy way to exit insert mode
inoremap jj <Esc>
inoremap jk <Esc>

" verymagic
nnoremap / /\v

" just because
nnoremap Y y$

" going up and down in wrapped lines
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <up>   gk

nnoremap <leader>f :echo expand("%:p")<CR>

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
"}}}
" CtrlP{{{
let g:ctrlp_root_markers = ['.ctrlp', '.project_root']
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v/(out|(Apps/Katana/)@<!objects)$',
    \ 'file': '\v\.(exe|so|dll|pyc|pyo)$',
    \ }
nnoremap <leader>t :CtrlPBufTagAll<CR>
nnoremap <leader>B :CtrlPBookmarkDir<CR>
nnoremap <leader>r :CtrlPMRUFiles<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>l :CtrlPLine<CR>
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
let g:airline_theme="luna"
let g:airline#extensions#whitespace#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tagbar#flags = 'f' " show extra context for current tag
"}}}
" UltiSnips{{{
" let g:UltiSnipsExpandTrigger       = "<C-J>"
" let g:UltiSnipsJumpForwardTrigger  = "<right>"
" let g:UltiSnipsJumpBackwardTrigger = "<left>"
" https://github.com/Valloric/YouCompleteMe/issues/36#issuecomment-40921899
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:snips_author                 = 'Nick Hutchinson'
let g:UltiSnipsSnippetDirectories  = ["UltiSnips"]
function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"

"}}}
"Sneak{{{
call yankstack#setup()
nmap s <Plug>Sneak_s
nmap S <Plug>Sneak_S
xmap s <Plug>Sneak_s
xmap S <Plug>Sneak_S
let g:sneak#s_next = 1
let g:gneak#streak = 1
"}}}
" Filetype/indentation{{{
set ts=4 sts=4 sw=4 expandtab
autocmd BufRead,BufNewFile *.m set filetype=objc
autocmd BufRead,BufNewFile *.mm set filetype=objcpp
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype lua setlocal ts=2 sts=2 sw=2
autocmd Filetype python setlocal tw=79 cc=80
"}}}
" GUI Options{{{
set guioptions-=l
set guioptions-=r
set guioptions-=L
set guioptions-=R
set guicursor+=a:blinkon0
set guioptions+=c  " Use console dialogs
if has("mac")
    let &guifont="Inconsolata for Powerline:h15"
elseif has("unix")
    let &guifont="DeJa Vu Sans Mono For Powerline 11"
endif
"}}}
" Folding"{{{
set foldmethod=syntax
set foldlevelstart=99
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
" Slime{{{
let g:slime_target = "tmux"
let g:slime_no_mappings = 1
xmap <leader>s <Plug>SlimeRegionSend
nmap <leader>s <Plug>SlimeMotionSend
nmap <leader>ss <Plug>SlimeLineSend
"}}}
if has("gui_running")
  " GUI is running or is about to start.
  " Maximize gvim window.
  set lines=999 columns=999
endif

" Syntastic{{{
let g:syntastic_lua_checkers = ['luajit']
let g:syntastic_python_checkers = ['python', 'pylint', 'pyflakes']
"}}}

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

let g:surround_{char2nr("C")} = "C{\r}"
let g:surround_{char2nr("L")} = "L{\r}"

command! -range=% StripTrailingWhitespace execute '<line1>,<line2>s/\v\s+$//e'

" vim: fdm=marker:foldlevel=0:

