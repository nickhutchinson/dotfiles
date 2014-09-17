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
try_source /workspace/Katana/QA_Resources/Resources/Apps/Katana/Modules/.qaBashrc
try_source /opt/intel/vtune_amplifier_xe_2013/amplxe-vars.sh >/dev/null


if is_interactive; then
    THEME=$(jq -r '.base16_scheme//"default.dark"' ~/.config/shell.json)
    THEME_FILEPATH=~/.config/base16-shell/base16-$THEME.sh
    try_source $THEME_FILEPATH
fi

