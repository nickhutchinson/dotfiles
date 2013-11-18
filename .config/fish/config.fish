set fish_greeting ''

set -x PATH                            \
  $HOME/.{cabal,rbenv,pyenv}/bin       \
  $HOME/.rbenv/plugins/ruby-build/bin  \
  /usr/local/{bin,sbin}                \
  /usr/local/share/npm/bin             \
  $PATH

if type rbenv > /dev/null
  . (rbenv init -|psub)
end

if type pyenv > /dev/null
  . (pyenv init -|psub)
end

if not type hash > /dev/null
  function hash; end
end

set -x EDITOR vim

# EC2 stuff
if test -d /usr/local/Library/LinkedKegs/ec2-api-tools/jars
  set -x JAVA_HOME (/usr/libexec/java_home)
  set -x EC2_PRIVATE_KEY (/bin/ls "$HOME"/.ec2/pk-*.pem | /usr/bin/head -1)
  set -x EC2_CERT (/bin/ls "$HOME"/.ec2/cert-*.pem | /usr/bin/head -1)
  set -x EC2_HOME "/usr/local/Library/LinkedKegs/ec2-api-tools/jars"
  set -x EC2_URL "https://us-west-2.ec2.amazonaws.com/"
end

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

