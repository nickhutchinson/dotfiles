#!/usr/bin/env bash
set -eu -o pipefail -o errtrace

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

cd "$SCRIPT_DIR"

echo_exec() {
    >&2 echo "+ $@"
    "$@"
}

link_dotfile() {
    echo_exec ln -si "$SCRIPT_DIR/$1" ~/."$1"
}

(
    set +e

    link_dotfile bash_profile
    link_dotfile bashrc
    link_dotfile cgdb
    link_dotfile clang-format
    link_dotfile gdbinit
    link_dotfile gitattributes
    link_dotfile gitconfig
    link_dotfile gitignore
    link_dotfile pdbrc
    link_dotfile tmux-linux.conf
    link_dotfile tmux-osx.conf
    link_dotfile tmux.conf
    link_dotfile tmuxline.conf
    link_dotfile vim
    link_dotfile vimrc
    link_dotfile Xresources
    link_dotfile ycm_extra_conf.py

    echo_exec mkdir -p ~/.config
    echo_exec mkdir -p ~/.config/fish

    link_dotfile config/bash16-shell
    link_dotfile config/bash16-xresources
    link_dotfile config/fish/functions
    link_dotfile config/fish/config.fish.d
    link_dotfile config/fish/config.fish
)
