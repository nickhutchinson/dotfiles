" Plugins {{{
call plug#begin('~/.vim/plugged')

" == General ==
Plug 'bling/vim-airline'
Plug 'bling/vim-bufferline'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'derekwyatt/vim-fswitch'
Plug 'edkolev/promptline.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'ivalkeen/vim-ctrlp-tjump'
Plug 'jpalardy/vim-slime'
Plug 'kien/ctrlp.vim'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree'
Plug 'ton/vim-bufsurf'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-vinegar'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

if isdirectory(expand('~/Documents/Development/ctrlp-luamatcher'))
  Plug '~/Documents/Development/ctrlp-luamatcher'
else
  Plug 'nickhutchinson/ctrlp-luamatcher'
end
" Plug 'JazzCore/ctrlp-cmatcher'  " Requires compilation

" == Text editing ==
Plug 'AndrewRadev/linediff.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'
Plug 'Lokaltog/vim-easymotion'
Plug 'majutsushi/tagbar'
Plug 'nelstrom/vim-visual-star-search'
Plug 'scrooloose/syntastic'
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
Plug 'derekwyatt/vim-scala'
Plug 'ekalinin/Dockerfile.vim'
Plug 'fatih/vim-go'
Plug 'fish-syntax'
Plug 'honza/vim-snippets'
Plug 'hynek/vim-python-pep8-indent'
Plug 'mitsuhiko/vim-jinja'
Plug 'nickhutchinson/vim-systemtap'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'othree/html5.vim'
Plug 'scons.vim'
Plug 'SirVer/ultisnips', { 'on': [], }
Plug 'suan/vim-instant-markdown'  " Requires setup, and lots of it.
Plug 'tikhomirov/vim-glsl'
Plug 'Keithbsmiley/swift.vim'
Plug 'tpope/vim-git'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-scriptease'
Plug 'Valloric/YouCompleteMe'  " Requires compilation
Plug 'vim-jp/cpp-vim'

call plug#end()
" }}}

" Options {{{
" Colour scheme {{{
if $TERM_PROGRAM != "Apple_Terminal"
  let base16colorspace=256
endif

set background=dark
colorscheme base16-monokai
" }}}

let mapleader = ","
set shortmess+=I
set list
set hidden
set number
set hlsearch
set ignorecase
set smartcase
set colorcolumn=81
set matchpairs+=<:>
let &listchars='tab:▸ ,eol:¬,extends:❯,precedes:❮,trail:·'
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
set undodir=~/.vim/undo//,/tmp/vim//,/tmp//
set wildignorecase  " case insensitive filename completion
set regexpengine=1 " Allegedly this is faster than the newfangled regex engine
set foldlevelstart=99
set scrolloff=10

if has("mac")
  set macmeta
endif

augroup trailing
  au!
  au InsertEnter * :set listchars-=trail:·
  au InsertLeave * :set listchars+=trail:·
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
set guioptions-=T
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
  au BufRead,BufNewFile *.tesc,*.tese,*.comp set ft=glsl
  au BufRead,BufNewFile *.m setf objc
  au BufRead,BufNewFile *.mm setf objcpp
  au BufRead,BufNewFile SConscript,SConstruct setf scons

  au Filetype cpp,c,objc,objcpp setl formatexpr=clang_format#formatexpr()
  au Filetype cpp,c,objc,objcpp setl fdm=indent
  au Filetype lua setl ts=2 sts=2 sw=2 fdm=indent
  au Filetype python setl formatexpr=autopep8#formatexpr()
  au Filetype python setl tw=79 cc=+1 fdm=indent
  au Filetype ruby setl ts=2 sts=2 sw=2
  au Filetype glsl setl comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://


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
nnoremap <Up>   gk

nnoremap <leader>go :BufSurfBack<CR>
nnoremap <leader>gp :BufSurfForward<CR>

" copy absolute path to clipboard
nnoremap <leader>cp :let @+ = expand("%:p")<CR>

" copy 'filename:lineno' (for easier GDB breakpoints)
nnoremap <leader>cP :let @+ = printf("%s:%d", expand("%:p"), line("."))<CR>

nnoremap <leader>cd :lcd %:h<CR>
nnoremap <leader>f :echo expand("%:p")<CR>
nnoremap <leader>F :echo printf("%s:%d", expand("%:p"), line("."))<CR>

command! -range=% StripTrailingWhitespace execute '<line1>,<line2>s/\v\s+$//e | let @/=""'

" Butter fingers
nnoremap <F1> <nop>
nnoremap Q <nop>
nnoremap K <nop>

"}}}

"Plugin Config {{{
" NERDTree"{{{
nnoremap <silent> <leader>n :NERDTreeToggle<CR>
nnoremap <silent> <leader>N :NERDTreeFind<CR>

let g:NERDTreeMapHelp = "<F1>"
let g:NERDTreeMapOpenInTab="<C-T>"
let g:NERDTreeMapOpenSplit="<C-S>"
let g:NERDTreeMapOpenVSplit="<C-V>"
let g:NERDTreeMapUpdirKeepOpen="-"

let g:NERDTreeRespectWildignore = 1
let g:NERDTreeSortOrder=[]
let g:NERDTreeMinimalUI=1

"}}}
" Wilgignore{{{
set wildignore+=*.exe,*.so,*.dll,*.pyc,*.pyo
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v/(out|(Apps/Katana/)@<!objects)$',
    \ }
let g:NERDTreeRespectWildIgnore = 1
"}}}
" CtrlP{{{
let g:CommandTFileScanner="find"
let g:CommandTMaxFiles=200000

let g:ctrlp_clear_cache_on_exit = 0
" let g:ctrlp_cmd = "CtrlPMixed"
let g:ctrlp_lazy_update = 50
let g:ctrlp_match_func  = {'match' : 'ctrlp_luamatcher#Match'}
" let g:ctrlp_match_func  = {'match' : 'matcher#cmatch'}
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:13'
let g:ctrlp_max_files=100000
let g:ctrlp_root_markers = ['.ctrlp', '.project_root']
nnoremap <leader>t :CtrlPBufTagAll<CR>
nnoremap <leader>B :CtrlPBookmarkDir<CR>
nnoremap <leader>r :CtrlPMRUFiles<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>l :CtrlPLine<CR>
nnoremap <C-]> :CtrlPtjump<cr>
vnoremap <C-]> :CtrlPtjumpVisual<cr>
"}}}
" YouCompleteMe{{{
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_extra_conf_globlist = ["~/.ycm_extra_conf.py"]
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
if executable("/usr/local/opt/python/bin/python")
  let g:ycm_path_to_python_interpreter = "/usr/local/opt/python/bin/python"
endif
nnoremap <leader><leader> :silent YcmCompleter GoTo<CR>
"}}}
" Eregex{{{
let g:eregex_default_enable = 0
" Toggles '/' to mean eregex search or normal Vim search
nnoremap <leader>/ :call eregex#toggle()<CR>
" }}}
" Airline/Bufferline{{{
let g:airline_powerline_fonts = 1
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tagbar#flags = 'f' " show extra context for current tag
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#syntastic#enabled = 0
let g:bufferline_echo = 0
let g:airline_theme="base16"
"}}}
" LocalVimrc{{{
let g:localvimrc_persistent = 1
let g:localvimrc_sandbox    = 0
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
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_glsl_checkers = ['glslang']
let g:syntastic_lua_checkers = ['luajit']
let g:syntastic_python_checkers = ['python', 'flake8']
let g:syntastic_python_flake8_args = '--select=F,C9 --max-complexity=10'
"}}}
"VimSession{{{
let g:session_autosave = 'yes'
let g:session_autoload = 'yes'
"}}}
" Instant Markdown{{{
let g:instant_markdown_autostart = 0
"}}}
" Fugitive"{{{
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
"}}}
" EasyMotion{{{
let g:EasyMotion_do_mapping = 0
"}}}
" Promptline {{{
let g:promptline_preset = {
    \'c' : [ promptline#slices#cwd() ],
    \'y' : [ promptline#slices#vcs_branch() ],
    \'warn' : [ promptline#slices#last_exit_code() ]}
"}}}
"}}}

" Misc{{{
augroup foundry
  au!
  au BufRead,BufNewFile *.args setf xml
augroup END

if filereadable(expand("~/.vimrc.local")) | source ~/.vimrc.local | endif
"}}}

" Scratchpad"{{{

" Cribbed from https://bitbucket.org/sjl/dotfiles/src/tip/vim/vimrc
" Don't move on *
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

" Replace current word
nnoremap c* :<C-U>let @/='\<'.expand("<cword>").'\>'<CR>:set hlsearch<CR>cgn

augroup lazy_load
  au!
  au InsertEnter * call plug#load('ultisnips') | au! lazy_load
augroup END

if has("gui_running")
  set lines=999 columns=999
endif




"}}}

nnoremap <leader>\| :vsp<CR>
nnoremap <leader>- :sp<CR>
nnoremap <leader><space> :noh<CR>

" vim: fdm=marker:foldlevel=0:
