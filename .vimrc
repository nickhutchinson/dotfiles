" Plugins {{{
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugin 'Lokaltog/vim-easymotion'
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-sensible'

Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'
Plugin 'bufkill.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'edkolev/tmuxline.vim'
Plugin 'embear/vim-localvimrc'
Plugin 'fish-syntax'
Plugin 'godlygeek/tabular'
Plugin 'honza/vim-snippets'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'ivalkeen/vim-ctrlp-tjump'
Plugin 'JazzCore/ctrlp-cmatcher'
Plugin 'jpalardy/vim-slime'
Plugin 'kana/vim-textobj-indent'
Plugin 'kana/vim-textobj-user'
Plugin 'kelan/gyp.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'nelstrom/vim-qargs'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'Raimondi/delimitMate'
Plugin 'scons.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'SirVer/ultisnips'
Plugin 'sjl/gundo.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-characterize'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-rsi'
Plugin 'tpope/vim-scriptease'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-tbone'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-vinegar'
Plugin 'Valloric/YouCompleteMe'
Plugin 'wellle/targets.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'

call vundle#end()            " required
filetype plugin indent on    " required
" }}}

" Options {{{
" Colour scheme {{{
set background=dark
let base16colorspace=256
colorscheme base16-default
" }}}
let mapleader = ","
set list
set hidden
set number
set hlsearch
set ignorecase
set smartcase
set colorcolumn=81
let &listchars='tab:▸ ,eol:¬,extends:❯,precedes:❮'
let &showbreak='↪ '
set numberwidth=2
set noswapfile
set cursorline
set clipboard=unnamed,unnamedplus
set noshowmode
set splitbelow
set formatoptions+=j
set splitright
set spelllang=en_gb
set undofile
set undodir=~/.vim/tmp/undo//,/tmp/vim//,/tmp//
set wildignorecase  " case insensitive filename completion
set regexpengine=1 " Allegedly this is faster than the newfangled regex engine
set foldlevelstart=99

if has("mac")
  set macmeta
endif

if $TERM_PROGRAM != "Apple_Terminal"
  let base16colorspace=256
endif
colorscheme base16-ocean

augroup trailing
  au!
  au InsertEnter * :set listchars-=trail:⌴
  au InsertLeave * :set listchars+=trail:⌴
augroup END

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
  let &guifont="DeJa Vu Sans Mono For Powerline 10"
endif
"}}}
"}}}
" Filetype-specific stuff{{{
set ts=4 sts=4 sw=4 expandtab
augroup vimrc_filetypes
  au!
  au BufRead,BufNewFile *.m setf objc
  au BufRead,BufNewFile *.mm setf objcpp
  au BufRead,BufNewFile SConscript,SConstruct setf scons
  au Filetype ruby setl ts=2 sts=2 sw=2
  au Filetype lua setl ts=2 sts=2 sw=2
  au Filetype python setl tw=79 cc=+1 fdm=indent
  au Filetype python setl formatexpr=autopep8#formatexpr()
  au Filetype cpp,c,objc,objcpp setl formatexpr=clang_format#formatexpr()

  " Don't let us get swamped with fugitive buffers
  au BufReadPost fugitive://* set bufhidden=delete
augroup END
let g:markdown_fenced_languages = ['python', 'lua', 'cpp']
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

" going up and down in wrapped lines
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <up>   gk

nnoremap <leader>cp :let @+ = expand("%:p")<CR>
nnoremap <leader>cP :let @+ = printf("%s:%d", expand("%:p"), line("."))<CR>

nnoremap <leader>cd :lcd %:h<CR>
nnoremap <leader>f :echo expand("%:p")<CR>
command! -range=% StripTrailingWhitespace execute '<line1>,<line2>s/\v\s+$//e | let @/=""'

"}}}
"Plugin Config"{{{
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
let g:NERDTreeMapUpdir="-"
"}}}
" Wilgignore{{{
set wildignore+=*.exe,*.so,*.dll,*.pyc,*.pyo
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v/(out|(Apps/Katana/)@<!objects)$',
    \ }
let g:NERDTreeRespectWildIgnore = 1
"}}}
" CtrlP{{{
let g:ctrlp_root_markers = ['.ctrlp', '.project_root']
let g:ctrlp_cmd = "CtrlPMixed"
nnoremap <leader>t :CtrlPBufTagAll<CR>
nnoremap <leader>B :CtrlPBookmarkDir<CR>
nnoremap <leader>r :CtrlPMRUFiles<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>l :CtrlPLine<CR>
nnoremap <C-]> :CtrlPtjump<cr>
vnoremap <C-]> :CtrlPtjumpVisual<cr>
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_match_func  = {'match' : 'matcher#cmatch'}
let g:ctrlp_max_files=100000
let g:ctrlp_lazy_update = 50
"}}}
" YouCompleteMe{{{
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
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
let g:airline#extensions#syntastic#enabled = 0
let g:bufferline_echo = 0
" let g:airline_theme="luna"
"}}}
" LocalVimrc{{{
let g:localvimrc_persistent=1
let g:localvimrc_sandbox=0
"}}}
" UltiSnips{{{
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:snips_author                 = 'Nick Hutchinson'
let g:UltiSnipsSnippetDirectories  = ["UltiSnips"]
let g:ultisnips_python_style = "doxygen"
" Hacky fixup for UltiSnips/YCM{{{
" https://github.com/Valloric/YouCompleteMe/issues/36#issuecomment-40921899
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
  au!
  au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
augroup END
"}}}
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
" Syntastic{{{
let g:syntastic_lua_checkers = ['luajit']
let g:syntastic_python_checkers = ['python', 'pylint', 'pyflakes']
"}}}
"VimSession{{{
let g:session_autosave = 'yes'
let g:session_autoload = 'yes'
"}}}
"}}}
" Misc{{{

" let g:surround_{char2nr("C")} = "C{\r}"
" let g:surround_{char2nr("L")} = "L{\r}"

augroup fixup_colorscheme
  au!
  au ColorScheme * highlight Search term=reverse  guifg=#073642 ctermfg=18
augroup END

augroup foundry
  au!
  au BufRead,BufNewFile *.args setf xml
 augroup END

 if filereadable(expand("~/.vimrc.local")) | source ~/.vimrc.local | endif
"}}}

" vim: fdm=marker:foldlevel=0:
