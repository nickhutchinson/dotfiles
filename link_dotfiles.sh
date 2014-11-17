#!/usr/bin/env bash
set -eu -o pipefail -o errtrace

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

cd "$SCRIPT_DIR"

echo_exec() {
    >&2 echo "+ $@"
    "$@"
}

link_dotfile() {
    if [[ ! -e "$HOME/.$1" ]]; then
        echo_exec ln -s "$SCRIPT_DIR/$1" "$HOME/.$1"
    else
        >&2 echo "- Skipping '~/.$1' (destination exists)"
    fi
}

(
    set +e

    echo_exec mkdir -p ~/.config
    echo_exec mkdir -p ~/.config/fish/{config.fish.d,functions}

    files=(
        bash_profile
        bashrc
        cgdb
        clang-format
        config/base16-shell
        config/base16-xresources
        config/fish/config.fish
        config/fish/{config.fish.d,functions}/*.fish
        gdbinit
        gitattributes
        gitconfig
        gitignore
        pdbrc
        promptline.sh
        tmux-linux.conf
        tmux-osx.conf
        tmux.conf
        tmuxline.conf
        vim
        vimrc
        Xresources
        ycm_extra_conf.py
    )

    for f in "${files[@]}"; do
        link_dotfile "$f"
    done

)
