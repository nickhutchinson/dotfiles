set -x PATH                            \
  "$HOME/opt/FBuildTools"              \
  "$HOME/.luarocks/bin"                \
  $PATH

set -x LUA_PATH "$HOME/.lua-packages/?.lua"

set -x KATANA_FILEBROWSER_QUICKLINKS "$HOME/Desktop:$HOME/Downloads:/tmp:/mnt/netqa/Testing/Katana/Scenes/"
