" Windows Nonsense "{{{
set encoding=utf-8

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
if !has('win32')
  Plug 'Shougo/vimproc.vim', {'do' : 'make'}
else
  Plug 'Shougo/vimproc.vim', {'do' : 'mingw32-make -f make_mingw64.mak'}
endif
Plug 'airblade/vim-rooter'
Plug 'bling/vim-bufferline'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jlfwong/vim-mercenary' " mercurial plugin

if has('win32')
  Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
  Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
endif
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-gtfo'
Plug 'mattn/webapi-vim' | Plug 'mattn/gist-vim'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-dispatch' " process launcher
Plug 'tpope/vim-eunuch' " UNIX commands
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rsi' " readline bindings
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth', { 'on': [] }
Plug 'tpope/vim-tbone' " tmux
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'xolox/vim-misc' | Plug 'xolox/vim-session'

" == Text editing ==
Plug 'AndrewRadev/linediff.vim'
Plug 'junegunn/vim-easy-align'
Plug 'kana/vim-textobj-user' | Plug 'kana/vim-textobj-indent'
Plug 'Konfekt/FastFold'
Plug 'majutsushi/tagbar'
Plug 'nelstrom/vim-visual-star-search'
Plug 'w0rp/ale'
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
Plug 'bennyyip/vim-yapf'
Plug 'fatih/vim-go'
Plug 'neoclide/jsonc.vim'
Plug 'nickhutchinson/vim-cpp'
Plug 'nickhutchinson/vim-systemtap'
Plug 'prettier/vim-prettier'
Plug 'rhysd/vim-clang-format'
Plug 'sheerun/vim-polyglot'
Plug 'shime/vim-livedown'
Plug 'vim-scripts/SWIG-syntax'
Plug 'vim-scripts/scons.vim'
if has('python3')
  Plug 'SirVer/ultisnips'
  Plug 'Valloric/YouCompleteMe'
endif
Plug 'psf/black', { 'tag': '*' }

call plug#end()

" }}}
" Options {{{
colorscheme base16-tomorrow

let mapleader = ","

let &showbreak='↪ '
let &listchars='tab:▸ ,eol:¬,extends:❯,precedes:❮'
set clipboard=unnamed,unnamedplus
set colorcolumn=101
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

set suffixes-=.h

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
  let &guifont="DeJa Vu Sans Mono 10"
elseif has("win32")
  let &guifont="Consolas:h9.5"
  if has("gui_running")
    colorscheme base16-tomorrow-night
  end
endif
"}}}
"}}}
" Filetype-specific stuff{{{
set ts=4 sts=4 sw=4 expandtab

" Disable markdown: the default vim plug-in loads faster
" Disable c/cpp: we're using a patched version
let g:polyglot_disabled = [
    \"markdown",
    \"c/cpp"
    \]

" Don't make trailing whitespace so angry
let g:python_highlight_space_errors = 0

augroup vimrc_filetypes
  au!
  au BufRead,BufNewFile *.m setf objc
  au BufRead,BufNewFile *.i set ft=swig
  au BufRead,BufNewFile *.mm setf objcpp
  au BufRead,BufNewFile *.ypp setf yacc.cpp
  au BufRead,BufNewFile SConscript,SConstruct setf scons

  " load vim-sleuth if filetype is not markdown to avoid performance bug. See:
  " https://github.com/tpope/vim-sleuth/issues/43.
  au Filetype * if &filetype != 'markdown' | call plug#load('vim-sleuth') | endif

  au Filetype c,cpp,objc,objcpp,cuda setl comments-=:// comments+=:///,://
  au Filetype c,cpp,objc,objcpp,cuda setl fdm=syntax
  au Filetype lua setl ts=2 sts=2 sw=2 fdm=indent
  au Filetype go setl tw=100 cc=+1 fdm=indent
  au Filetype ruby setl ts=2 sts=2 sw=2
  au Filetype javascript setl ts=2 sts=2 sw=2 tw=88
  au Filetype typescript setl ts=2 sts=2 sw=2 tw=88
  au FileType dirvish setlocal nospell

  au FileType c,cpp,objc,objcpp,cuda,proto
      \ setl formatexpr=clang_format#replace(v:lnum,v:lnum+v:count-1)
augroup END
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
let g:yapf#auto_formatexpr = 1
" FZF{{{
nnoremap <C-P> :Files<cr>
nnoremap <leader>r :History<cr>
nnoremap <C-]> :Tags <c-r><c-w><cr>
let $FZF_DEFAULT_COMMAND='rg --files'
" }}}
" YouCompleteMe{{{
let g:ycm_extra_conf_globlist = [
      \ '~/Code/eyebrow/*',
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
" ALE{{{
" Pylint gets confused if files in the CWD are named the same as standard
" modules (even if their case differs).
let g:ale_python_pylint_change_directory = 0
if has('mac')
  let g:ale_cpp_clangtidy_executable = '/usr/local/opt/llvm/bin/clang-tidy'
endif
let g:ale_linters = {
\   'c': [],
\   'cpp': [],
\   'objcpp': [],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint', 'prettier'],
\   'c': ['clang-format'],
\   'cpp': ['clang-format'],
\   'objcpp': ['clang-format'],
\}
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
" Go {{{
let g:go_addtags_transform = 'camelcase'
" }}}
" Promptline/Tmuxline {{{
if !has('gui_running')
  let g:tmuxline_powerline_separators = 0
  let g:promptline_powerline_symbols = 0
  let s:hg_branch = {
    \'function_name': 'hg_branch',
    \'function_body': [
      \'function hg_branch {',
      \'  local branch_symbol="' . promptline#symbols#get().vcs_branch . '"',
      \'  local dir=$PWD',
      \'  while true; do',
      \'    if [[ -d "$dir/.hg" ]]; then',
      \'      printf "%s%s" "$branch_symbol" "$(',
      \'        cat "$dir/.hg/bookmarks.current" 2>/dev/null ||',
      \'        cat "$dir/.hg/branch" 2>/dev/null ||',
      \'        echo "default"',
      \'      )"',
      \'      return 0',
      \'    elif [[ "$dir" != "/" ]]; then',
      \'      dir=$(dirname "$dir")',
      \'    else',
      \'      return 1',
      \'    fi',
      \'  done',
      \'}',
    \]
  \}
  let g:promptline_preset = {
      \'c':    [promptline#slices#cwd()],
      \'y':    [promptline#slices#vcs_branch({'git':1, 'svn':1}), s:hg_branch],
      \'warn': [promptline#slices#last_exit_code()]}
endif
"}}}
" Projectionist {{{
let g:projectionist_heuristics = {
  \   '*': {
  \     '*.h': {'alternate': ['{}.cc', '{}.cpp']},
  \     '*.cpp': {'alternate': '{}.h'},
  \     '*.cc': {'alternate': '{}.h'}
  \   }
  \ }
"}}}
" vim: fdm=marker:foldlevel=0:
