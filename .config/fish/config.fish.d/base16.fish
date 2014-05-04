set -l BASE16_SCHEME ocean
set -l BASE16_SHELL "$HOME/.config/base16-shell/base16-$BASE16_SCHEME.dark.sh"

if test -f "$BASE16_SHELL" -a -z "$BASE16_SCHEME_CURRENT"
  eval sh "$BASE16_SHELL"
  set -x BASE16_SCHEME_CURRENT "$BASE16_SCHEME"
end
