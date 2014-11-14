let s:script_dir = escape(expand('<sfile>:p:h' ), '\')
let s:python_script_dir = s:script_dir . '/../python'

python << EOF
import vim
import sys
SCRIPT_DIR = vim.eval('s:python_script_dir')
if SCRIPT_DIR not in sys.path:
    sys.path.insert(0, SCRIPT_DIR)
EOF

function! autopep8#formatexpr()
  if mode() ==# 'i' || mode() ==# 'R'
    return -1
  endif

python << EOF
if True:
  import formatters.autopep8
  import vim
  formatters.autopep8.AutoPep8(
      vim.vvars['lnum'], 
      vim.vvars['lnum'] + vim.vvars['count'])
EOF
endfunction

