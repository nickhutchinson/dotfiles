set fish_greeting ''
set -x LESS '-F -g -i -M -R -S -w -X -z-4'

set -x EDITOR vim

for p in "$HOME/bin" /usr/local/{bin,sbin}
  _append_path "$p"
end

################################################################################
alias cp 'cp -i'
alias ln 'ln -i'
alias rm 'rm -i'
alias mv 'mv -i'
alias mkdir 'mkdir -p'

alias df 'df -kh'
alias du 'du -kh'

if not type pbcopy > /dev/null
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

alias gdc 'git diff --cached'
alias gd 'git diff'
alias gc 'git checkout'
alias gs 'git status'
alias gh 'git hist'

################################################################################
set -l script_dir (dirname (status -f))

if test -d "$script_dir/config.fish.d"
  for f in "$script_dir/config.fish.d/"*.fish
    source $f
  end
end


