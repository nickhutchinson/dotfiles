" Plugins {{{
set nocompatible
filetype off

set shell=/bin/bash
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'airblade/vim-gitgutter'
Plugin 'bkad/CamelCaseMotion'
Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'
Plugin 'bufkill.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'derekwyatt/vim-scala'
Plugin 'edkolev/tmuxline.vim'
Plugin 'embear/vim-localvimrc'
Plugin 'fish-syntax'
Plugin 'gmarik/Vundle.vim'
Plugin 'godlygeek/tabular'
Plugin 'hdima/python-syntax'
Plugin 'honza/vim-snippets'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'int3/vim-extradite'
Plugin 'ivalkeen/vim-ctrlp-tjump'
Plugin 'JazzCore/ctrlp-cmatcher'  " Requires compilation
Plugin 'jpalardy/vim-slime'
Plugin 'kana/vim-textobj-indent'
Plugin 'kana/vim-textobj-user'
Plugin 'kien/ctrlp.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'majutsushi/tagbar'
Plugin 'mattn/emmet-vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'oblitum/rainbow'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'othree/html5.vim'
Plugin 'rking/ag.vim'
Plugin 'scons.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'SirVer/ultisnips'
Plugin 'sjl/gundo.vim'
Plugin 'suan/vim-instant-markdown'  " Requires setup
Plugin 'tommcdo/vim-exchange'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-characterize'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-jdaddy'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-rsi'
Plugin 'tpope/vim-scriptease'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-tbone'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-vinegar'
Plugin 'Valloric/YouCompleteMe'  " Requires compilation
Plugin 'vcscommand.vim'
Plugin 'vim-jp/cpp-vim'
Plugin 'wellle/targets.vim'
Plugin 'wikimatze/hammer.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'
Plugin 'xolox/vim-session'

call vundle#end()
filetype plugin indent on
" }}}

" Options {{{
" Colour scheme {{{
set background=dark
let base16colorspace=256
colorscheme base16-default
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

if $TERM_PROGRAM != "Apple_Terminal"
  let base16colorspace=256
endif
colorscheme base16-ocean

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
  au Filetype cpp,c,objc,objcpp setl formatexpr=clang_format#formatexpr() fdm=syntax
  au Filetype lua setl ts=2 sts=2 sw=2
  au Filetype python setl formatexpr=autopep8#formatexpr()
  au Filetype python setl tw=79 cc=+1 fdm=indent
  au Filetype ruby setl ts=2 sts=2 sw=2
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
"Plugin Config"{{{
" NERDTree"{{{
nnoremap <silent> <leader>n :NERDTreeToggle<CR>
nnoremap <silent> <leader>N :NERDTreeFind<CR>

let g:NERDTreeMapHelp = "<F1>"
let g:NERDTreeMapOpenInTab="<C-T>"
let g:NERDTreeMapOpenSplit="<C-S>"
let g:NERDTreeMapOpenVSplit="<C-V>"
let g:NERDTreeMapUpdirKeepOpen="-"

let g:NERDTreeRespectWildignore = 1
let g:NERDTreeShowBookmarks=1
let g:NERDTreeSortOrder=[]

"}}}
" Wilgignore{{{
set wildignore+=*.exe,*.so,*.dll,*.pyc,*.pyo
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v/(out|(Apps/Katana/)@<!objects)$',
    \ }
let g:NERDTreeRespectWildIgnore = 1
"}}}
" CtrlP{{{
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cmd = "CtrlPMixed"
let g:ctrlp_lazy_update = 50
let g:ctrlp_match_func  = {'match' : 'matcher#cmatch'}
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
let g:airline_theme="base16"
"}}}
" LocalVimrc{{{
let g:localvimrc_persistent=1
let g:localvimrc_sandbox=0
"}}}
" UltiSnips{{{
let g:snips_author                 = 'Nick Hutchinson'
let g:ultisnips_python_style = "doxygen"
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsSnippetDirectories  = ["UltiSnips"]
"}}}
" Rainbox
let g:rainbow_active = 1
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
" Instant Markdown{{{
let g:instant_markdown_autostart = 0
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

" Scratchpad"{{{
" Cribbed from https://bitbucket.org/sjl/dotfiles/src/tip/vim/vimrc

" Don't move on *
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

" Replace current word
nnoremap c* :<C-U>let @/='\<'.expand("<cword>").'\>'<CR>:set hlsearch<CR>cgn

" Fugitive
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>

function! <SID>DoHighlighting()
  " syn match myConstant "\v<k\w+>"
  " syn match myConstant "\v<[A-Z0-9_]+>"
  " hi link myConstant Constant
endfunction

augroup syntax
  au!
  au filetype cpp call <SID>DoHighlighting()
augroup END

nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
"}}}

let g:EasyMotion_do_mapping = 0

" vim: fdm=marker:foldlevel=0:
