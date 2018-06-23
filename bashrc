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

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
