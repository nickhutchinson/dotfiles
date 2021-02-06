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
    echo_exec mkdir -p ~/.config/mr/config.d
    echo_exec mkdir -p ~/.config/fish/conf.d

    files=(
        bash_profile
        bashrc
        cgdb
        clang-format
        config/fish/config.fish
        config/fish/conf.d/*.fish
        config/mr/config.d/*
        gdbinit
        gitattributes
        gitconfig
        gitignore
        mrconfig
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
