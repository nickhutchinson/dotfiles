set fish_greeting ''
set -x LESS '-F -g -i -M -R -S -w -X -z-4'

set -x EDITOR nvim

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

if test -d "$XDG_CONFIG_DIR/fish/config.fish.d"
  for f in "$XDG_CONFIG_DIR/fish/config.fish.d/"*.fish
    source $f
  end
end


