# .bashrc
try_source() {
    if [[ -f $1 ]]; then
        source "$1"
    fi
}

is_interactive() {
    case "$-" in
        *i*)    true;;
        *)      false;;
    esac
}

try_source /etc/bashrc

if is_interactive; then
    try_source "$HOME/.config/base16-shell/base16-ocean.dark.sh"
    export TERM=xterm-256color
fi
