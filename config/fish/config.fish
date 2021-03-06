set fish_greeting ''
set -x LESS '-F -g -i -M -R -S -w -X -z-4'

set -x VISUAL nvim

################################################################################
alias cp 'cp -i'
alias ln 'ln -i'
alias rm 'rm -i'
alias mv 'mv -i'
alias mkdir 'mkdir -p'

alias df 'df -kh'
alias du 'du -kh'

if not type pbcopy >/dev/null 2>&1
  alias pbcopy 'xsel --clipboard --input'
  alias pbpaste 'xsel --clipboard --output'
end

alias pbc pbcopy
alias pbp pbpaste

switch (uname)
case 'Linux'
  alias o xdg-open
case 'Darwin'
  alias o open
end

################################################################################
set -l XDG_CONFIG_DIR "$XDG_CONFIG_DIR"
if test -z "$XDG_CONFIG_DIR"
  set XDG_CONFIG_DIR "$HOME/.config"
end

if type jenv >/dev/null 2>&1
  source (jenv init -|psub)
end

