if status --is-interactive
    set -l base16_scheme 'monokai.dark'
    set -l base16_path "$HOME/.config/base16-shell/base16-$base16_scheme.sh"
    if test -f $base16_path
        eval sh "$base16_path"
    end
end
