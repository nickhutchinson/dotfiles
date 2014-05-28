if not set -q BASE16_SCHEME
    set -x BASE16_SCHEME solarized
    set -l BASE16_SHELL "$HOME/.config/base16-shell/base16-$BASE16_SCHEME.dark.sh"
    if test -f $BASE16_SHELL
        eval sh "$BASE16_SHELL"
    end
    #echo "set terminal vars"
else
    #echo "Not setting terminal vars"
end
