" Plugins {{{
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" Plugin 'Lokaltog/vim-easymotion'
" Plugin 'sjl/gundo.vim'
" Plugin 'wellle/targets.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'
Plugin 'moll/vim-bbye'
Plugin 'chriskempson/base16-vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'edkolev/tmuxline.vim'
Plugin 'embear/vim-localvimrc'
Plugin 'fish-syntax'
Plugin 'gmarik/Vundle.vim'
Plugin 'godlygeek/tabular'
Plugin 'honza/vim-snippets'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'ivalkeen/vim-ctrlp-tjump'
Plugin 'JazzCore/ctrlp-cmatcher'
Plugin 'jpalardy/vim-slime'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'nelstrom/vim-qargs'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'SirVer/ultisnips'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-rsi'
Plugin 'tpope/vim-scriptease'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-vinegar'
Plugin 'Valloric/YouCompleteMe'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'

call vundle#end()            " required
filetype plugin indent on    " required
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
let &listchars='tab:▸ ,eol:¬'
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
set undofile
set undodir=~/.vim/tmp/undo//,/tmp/vim//,/tmp//

if has("mac")
  set macmeta
endif

if $TERM_PROGRAM != "Apple_Terminal"
  let base16colorspace=256
endif
colorscheme base16-ocean

" GUI Options{{{
set mouse+=a
if &term =~ '^screen'
  " tmux knows the extended mouse mode
  set ttymouse=xterm2
endif

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
"}}}
" Filetype-specific stuff{{{
set ts=4 sts=4 sw=4 expandtab
augroup vimrc_filetypes
  autocmd!
  autocmd BufRead,BufNewFile *.m setf objc
  autocmd BufRead,BufNewFile *.mm setf objcpp
  autocmd Filetype ruby setl ts=2 sts=2 sw=2
  autocmd Filetype lua setl ts=2 sts=2 sw=2
  autocmd Filetype python setl tw=79 cc=+1
  autocmd Filetype cpp,c,objc,objcpp setl formatexpr=clang_format#formatexpr()
augroup END

"}}}
" Mappings/Commands {{{

" http://vimcasts.org/episodes/the-edit-command/
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

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
command! -range=% StripTrailingWhitespace execute '<line1>,<line2>s/\v\s+$//e'

command! -bang -complete=buffer -nargs=? BDelete Bdelete<bang> <args>

"}}}
"Plugin Config{{{
" NERDTree"{{{
nnoremap <silent> <leader>n :NERDTreeToggle<CR>
nnoremap <silent> <leader>N :NERDTreeFind<CR>
let g:NERDTreeRespectWildignore = 1
let g:NERDTreeMapHelp = "<F1>"
let g:NERDTreeShowBookmarks=1
let g:NERDTreeSortOrder=[]
let g:NERDTreeMapOpenInTab="<C-T>"
let g:NERDTreeMapOpenSplit="<C-S>"
let g:NERDTreeMapOpenVSplit="<C-V>"
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
"}}}
" YouCompleteMe{{{
let g:ycm_extra_conf_globlist = ["~/.ycm_extra_conf.py"]
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_path_to_python_interpreter = "/usr/bin/python"
nnoremap <leader><leader> :silent YcmCompleter GoTo<CR>
"}}}
" Airline/Bufferline{{{
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tagbar#flags = 'f' " show extra context for current tag
let g:airline#extensions#whitespace#enabled = 0
let g:bufferline_echo = 0
"}}}
" LocalVimrc{{{
let g:localvimrc_persistent=1
let g:localvimrc_sandbox=0
"}}}
" UltiSnips{{{
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

augroup vimrc_ultisnips_fixup
  autocmd!
  autocmd InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
augroup END

"}}}
" Syntastic{{{
let g:syntastic_lua_checkers = ['luajit']
let g:syntastic_python_checkers = ['python', 'pylint', 'pyflakes']
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
" VimSession{{{
let g:session_autosave = 'yes'
let g:session_autoload = 'yes'
"}}}
"}}}

if filereadable(expand("~/.vimrc.local")) | source ~/.vimrc.local | endif

" vim: fdm=marker:foldlevel=0:
