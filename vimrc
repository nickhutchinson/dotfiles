" Windows Nonsense "{{{
set encoding=utf-8

if has('win32unix') " Cygwin
  set rtp^=~/vimfiles
endif

if has('win32')
  set shell=$COMSPEC
endif
"}}}
" Plugins {{{
call plug#begin()

" == General ==
if !has('gui_running')
  Plug 'edkolev/promptline.vim'
  Plug 'edkolev/tmuxline.vim'
endif
Plug 'bling/vim-bufferline'
Plug 'chriskempson/base16-vim', {'commit': '6fa899d'} " Newer commits break light scheme.
Plug 'christoomey/vim-tmux-navigator'
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-gtfo'
Plug 'kien/ctrlp.vim' | Plug 'ivalkeen/vim-ctrlp-tjump' | Plug 'nickhutchinson/ctrlp-luamatcher'
Plug 'mattn/webapi-vim' | Plug 'mattn/gist-vim'
Plug 'mhinz/vim-signify'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-dispatch' " process launcher
Plug 'tpope/vim-eunuch' " UNIX commands
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rsi' " readline bindings
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-tbone' " tmux
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'xolox/vim-misc' | Plug 'xolox/vim-session'

" == Text editing ==
Plug 'AndrewRadev/linediff.vim'
Plug 'junegunn/goyo.vim' " focussed text editing
Plug 'junegunn/vim-easy-align'
Plug 'kana/vim-textobj-user' | Plug 'kana/vim-textobj-indent'
Plug 'Konfekt/FastFold'
Plug 'Lokaltog/vim-easymotion'
Plug 'majutsushi/tagbar'
Plug 'nelstrom/vim-visual-star-search'
Plug 'neomake/neomake'
Plug 'PeterRincker/vim-argumentative'
Plug 'sjl/gundo.vim'
Plug 'tommcdo/vim-exchange'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'

" == Syntax/filetype-specific ==
Plug 'fatih/vim-go'
Plug 'nickhutchinson/vim-cmake-syntax'
Plug 'nickhutchinson/vim-systemtap'
Plug 'raymond-w-ko/vim-lua-indent'
Plug 'scons.vim'
Plug 'sheerun/vim-polyglot'
Plug 'shime/vim-livedown'
Plug 'SWIG-syntax'
if has('python')
  Plug 'SirVer/ultisnips'
  Plug 'Valloric/YouCompleteMe'
endif

call plug#end()

" }}}
" Options {{{
" Colour scheme {{{
if $TERM_PROGRAM !=# "Apple_Terminal"
  let base16colorspace=256
endif

set background=dark
colorscheme base16-ocean

if &term !=# "cygwin" && hostname() !~? "\\v(gabor|crerar|jordan)"
  let h = strftime("%H")
  if 7 <= h && h <= 17
    set background=light
  else
    set background=dark
  endif
endif
" }}}

let mapleader = ","

let &showbreak='↪ '
let &listchars='tab:▸ ,eol:¬,extends:❯,precedes:❮'
let g:python2_host_prog='/usr/bin/python'
set clipboard=unnamed,unnamedplus
set colorcolumn=81
set cursorline
set foldlevelstart=99
set formatoptions+=jn " j: join commented lines sensibly; n: indent lists properly
let &formatlistpat="\\v^\\s*(\\d+[\\]:.)}\\t ]|-|\\*)\\s*"
set hidden
set hlsearch
set ignorecase
set list
set matchpairs+=<:>
set noshowmode
set noswapfile
set number
set numberwidth=2
set scrolloff=10
set shortmess+=I
set smartcase
set spell
set spelllang=en_gb
set splitbelow
set splitright
set undofile
set wildignorecase  " case insensitive filename completion

" Configure temp directories
if has("win32") || has("win32unix")
  let s:tmpdir = expand("~/AppData/Local/Temp/vim")
else
  let s:tmpdir = !empty($TMPDIR) ? $TMPDIR : "/tmp"
  let s:tmpdir .= expand("/vim.$USER")
endif
:silent! call mkdir(s:tmpdir, "p", 0700)
let &dir = s:tmpdir
let &undodir = s:tmpdir
let &backupdir = s:tmpdir

" GUI Options{{{
if has("gui_running")
  set lines=999 columns=999
endif

set mouse=a " enable mouse mode

" Disable left/right scrollbars, toolbar.
set guioptions-=L
set guioptions-=r
set guioptions-=T

set guicursor+=a:blinkon0
set guioptions+=c  " Use console dialogs
if has("mac")
  let &guifont="Inconsolata:h15"
elseif has("unix")
  let &guifont="DeJa Vu Sans Monoe 10"
elseif has("win32")
  let &guifont="DeJaVu_Sans_Mono:h10"
endif
"}}}
"}}}
" Filetype-specific stuff{{{
set ts=4 sts=4 sw=4 expandtab

augroup vimrc_filetypes
  au!
  au BufWritePost * Neomake

  au BufRead,BufNewFile *.m setf objc
  au BufRead,BufNewFile *.i set ft=swig
  au BufRead,BufNewFile *.mm setf objcpp
  au BufRead,BufNewFile *.ypp setf yacc.cpp
  au BufRead,BufNewFile SConscript,SConstruct setf scons

  au Filetype c,cpp,objc,objcpp,cuda setl comments-=:// comments+=:///,://
  au Filetype c,cpp,objc,objcpp,cuda setl fdm=syntax
  au Filetype c,cpp,objc,objcpp,cuda setl formatexpr=clang_format#formatexpr()
  au Filetype lua setl ts=2 sts=2 sw=2 fdm=indent
  au Filetype python setl formatexpr=yapf#formatexpr()
  au Filetype python setl tw=79 cc=+1 fdm=indent
  au Filetype go setl tw=100 cc=+1 fdm=indent
  au Filetype ruby setl ts=2 sts=2 sw=2
  au FileType dirvish setlocal nospell
augroup END
let g:markdown_fenced_languages = ['python', 'lua', 'cpp']
" Fix buggy syntax highlighting in bash scripts.
" <http://stackoverflow.com/questions/11044378/syntax-highlighting-bugs-of-vim-7-3-for-bash-scripts>
let g:sh_no_error=1
set wildignore+=*.exe,*.so,*.dll,*.pyc,*.pyo
let g:load_doxygen_syntax=1
"}}}
" Mappings/Commands {{{

" http://vimcasts.org/episodes/the-edit-command/
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Don't move on *. Credit: https://bitbucket.org/sjl/dotfiles/src/tip/vim/vimrc
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

" Easy way to exit insert mode
inoremap jj <Esc>
inoremap jk <Esc>

" verymagic
nnoremap / /\v
vnoremap / /\v

" going up and down in wrapped lines
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk

" Format paragraph/selection
nnoremap Q gqip
vnoremap Q gq

" copy absolute path to clipboard
nnoremap <leader>cp :let @+ = expand("%:p")<CR>

" copy 'filename:lineno' (for easier GDB breakpoints)
nnoremap <leader>cP :let @+ = printf("%s:%d", expand("%:p"), line("."))<CR>

nnoremap <leader>cd :lcd %:h<CR>
nnoremap <leader>f :echo expand("%:p")<CR>
nnoremap <leader>F :echo printf("%s:%d", expand("%:p"), line("."))<CR>

command! -range=% StripTrailingWhitespace execute '<line1>,<line2>s/\v\s+$//e | let @/=""'

nnoremap <F9> :Dispatch<CR>

" Fat fingers
nnoremap <F1> <nop>
nnoremap K <nop>
command! -bang -nargs=? -complete=file E e<bang> <args>
command! -bang -nargs=? -complete=file W w<bang> <args>
command! -bang -nargs=? -complete=file Wq wq<bang> <args>
command! -bang -nargs=? -complete=file WQ wq<bang> <args>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Q q<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
"}}}
"Plugin Config {{{
" CtrlP{{{
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_custom_ignore = {'dir': '\v/(out|(Apps/Katana/)@<!objects)$'}
let g:ctrlp_lazy_update = 50
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:13'
let g:ctrlp_max_files=100000
let g:ctrlp_root_markers = ['.ctrlp', '.project_root']
if has('lua')
  let g:ctrlp_match_func  = {'match': 'ctrlp_luamatcher#Match'}
endif
nnoremap <leader>t :CtrlPBufTagAll<CR>
nnoremap <leader>B :CtrlPBookmarkDir<CR>
nnoremap <leader>r :CtrlPMRUFiles<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>l :CtrlPLine<CR>
nnoremap <C-]> :CtrlPtjump<cr>
vnoremap <C-]> :CtrlPtjumpVisual<cr>
"}}}
" YouCompleteMe{{{
let g:ycm_extra_conf_globlist = [
      \ '/workspace/Katana/*',
      \ '~/.ycm_extra_conf.py']

let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
nnoremap <leader><leader> :silent YcmCompleter GoTo<CR>
"}}}
" Airline/Bufferline{{{
let g:airline#extensions#tmuxline#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tagbar#flags = 'f' " show extra context for current tag
let g:airline#extensions#whitespace#enabled = 0

let g:bufferline_echo = 0
let g:airline_theme="base16"
"}}}
" Gist {{{
let g:gist_open_browser_after_post = 1
"}}}
" UltiSnips{{{
let g:snips_author                 = 'Nick Hutchinson'
let g:ultisnips_python_style       = "doxygen"
let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsSnippetDirectories  = ["UltiSnips"]
"}}}
" Easy Align{{{
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader>a <Plug>(EasyAlign)
"}}}
" Tagbar{{{
nnoremap <F8> :TagbarToggle<CR>
let g:tagbar_sort = 0
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
" NeoMake{{{
let g:neomake_glsl_glslangValidator_maker = {
  \ 'args': ['--verbose'],
  \ 'errorformat': '%Eerror: %\\d%\\+:%l: %m',
  \ }
let g:neomake_glsl_enabled_makers = ['glslangValidator']

let g:neomake_cpp_enabled_makers = []
"}}}
"VimSession{{{
let g:session_autosave = 'yes'
let g:session_autoload = 'yes'
"}}}
" Fugitive"{{{
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
"}}}
" EasyMotion{{{
let g:EasyMotion_do_mapping = 0
"}}}
" Promptline/Tmuxline {{{
if !has('gui_running')
  let g:tmuxline_powerline_separators = 0
  let g:promptline_powerline_symbols = 0
  let g:promptline_preset = {
      \'c' : [ promptline#slices#cwd() ],
      \'y' : [ promptline#slices#vcs_branch() ],
      \'warn' : [ promptline#slices#last_exit_code() ]}
endif
"}}}
" Ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
cnoreabbrev Ag Ack
"}}}
" vim: fdm=marker:foldlevel=0:
