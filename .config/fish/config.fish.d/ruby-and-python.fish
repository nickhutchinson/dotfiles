
set -x PATH                            \
  $HOME/.{rbenv,pyenv}/bin             \
  $HOME/.rbenv/plugins/ruby-build/bin  \
  $PATH

if type rbenv > /dev/null
  . (rbenv init -|psub)
end

if type pyenv > /dev/null
  . (pyenv init -|psub)
end
  . 
if not type hash > /dev/null
  function hash; end
end

 
