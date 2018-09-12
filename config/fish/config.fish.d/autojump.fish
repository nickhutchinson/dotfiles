if test -f "$HOME/.autojump/etc/profile.d/autojump.fish"
  . "$HOME/.autojump/etc/profile.d/autojump.fish"

else if test -f /usr/local/share/autojump/autojump.fish
  . /usr/local/share/autojump/autojump.fish

else if test -f /etc/profile.d/autojump.fish
  . /etc/profile.d/autojump.fish
end

