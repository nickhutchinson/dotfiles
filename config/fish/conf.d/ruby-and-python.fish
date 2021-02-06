if test -d "$HOME/.pyenv/bin"
    set PATH "$HOME/.pyenv/bin" $PATH
end

if test -d "$HOME/.rbenv/bin"
    set PATH "$HOME/.rbenv/bin" $PATH
end

if type rbenv >/dev/null 2>&1
  source (rbenv init -|psub)
end

if command -v pyenv 1>/dev/null 2>&1
  pyenv init - | source
end
