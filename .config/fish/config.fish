set fish_greeting ''

set -x PATH                            \
  $HOME/.{rbenv,pyenv}/bin             \
  $HOME/.rbenv/plugins/ruby-build/bin  \
  /usr/local/{bin,sbin}                \
  $PATH

if type rbenv > /dev/null
  source (rbenv init -|psub)
end

if type pyenv > /dev/null
  source (pyenv init -|psub)
end

if type autojump > /dev/null
  . (dirname (type -p autojump))/../etc/autojump.fish
end

if not type hash > /dev/null
  function hash; end
end

set -x EDITOR vim

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

if test -d $HOME/.config/fish/config.fish.d
  for f in $HOME/.config/fish/config.fish.d/*.fish
    source $f
  end
end

