_append_path "$HOME/.cabal/bin"

_append_path "$HOME/.pyenv/bin"
_append_path "$HOME/.pyenv/plugins/python-build/bin"

_append_path "$HOME/.rbenv/bin"
_append_path "$HOME/.rbenv/plugins/ruby-build/bin"


if type rbenv > /dev/null
  source (rbenv init -|psub)
end

if type pyenv > /dev/null
  source (pyenv init -|psub)
end

if not type hash > /dev/null
  function hash; end
end

 
