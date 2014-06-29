
set -x PATH                              \
  $HOME/.{rbenv,pyenv}/bin               \
  $HOME/.rbenv/plugins/ruby-build/bin    \
  $HOME/.pyenv/plugins/python-build/bin  \
  $PATH

if type rbenv > /dev/null
  source (rbenv init -|psub)
end

if type pyenv > /dev/null
  source (pyenv init -|psub)
end

if not type hash > /dev/null
  function hash; end
end

 
