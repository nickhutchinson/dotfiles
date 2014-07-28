set fish_greeting ''
set -x LESS '-F -g -i -M -R -S -w -X -z-4'

set -x EDITOR vim
# set -x TERM xterm-256color

set -x PATH $HOME/opt/bin /usr/local/{bin,sbin} $PATH
set -x TERM xterm-256color

################################################################################
alias cp 'cp -i'
alias ln 'ln -i'
alias rm 'rm -i'
alias mv 'mv -i'
alias mkdir 'mkdir -p'

alias df 'df -kh'
alias du 'du -kh'

if not type pbcopy > /dev/null
  alias pbcopy="xsel --clipboard --input"
  alias pbpaste="xsel --clipboard --output"
end

alias pbc pbcopy
alias pbp pbpaste

switch (uname)
case "Linux"
  alias o xdg-open
case "Darwin"
  alias o open
end

################################################################################
if test -d $HOME/.config/fish/config.fish.d
  for f in $HOME/.config/fish/config.fish.d/*.fish
    source $f
  end
end


