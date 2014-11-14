if type autojump > /dev/null
  . (dirname (type -p autojump))/../etc/autojump.fish
end

set -l AUTOJUMP_PATH "$HOME/.autojump/etc/profile.d/autojump.fish"
if test -f $AUTOJUMP_PATH
  . $AUTOJUMP_PATH
end

