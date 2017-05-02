#!/bin/bash

if (( ${BASH_VERSION%%.*} < 4 )) ; then
    >&2 echo "Requires Bash version 4 or higher"
    exit 1
fi

set -e

SCRIPT=`realpath $0`
DIR=`dirname $SCRIPT`
NEW=
REPLACED=
SKIPPED=

link_prompt() {
    if [ -e $2 ]; then
        read -r -p "replace ‘$2’? "
        if [[ ${REPLY,,} =~ ^y(es)?$ ]]; then
            rm -rf $2
            ln -sf $1 $2
            REPLACED="$REPLACED\n$2"
        else
            SKIPPED="$SKIPPED\n$2"
        fi
    else
        ln -sf $1 $2
        NEW="$NEW\n$2"
    fi
}

# git
link_prompt "$DIR/git/gitconfig" "$HOME/.gitconfig"

# vim
link_prompt "$DIR/vim/vimrc" "$HOME/.vimrc"
link_prompt "$DIR/vim/gvimrc" "$HOME/.gvimrc"
link_prompt "$DIR/vim" "$HOME/.vim"

# bash
link_prompt "$DIR/bash/bashrc" "$HOME/.bashrc"
link_prompt "$DIR/bash/bash_profile" "$HOME/.bash_profile"
link_prompt "$DIR/bash/inputrc" "$HOME/.inputrc"

# bash completions
completions_dir=$HOME/.local/share/bash-completion/completions
mkdir -p "$completions_dir"
link_prompt "$DIR/bash/completions/fzf" "$completions_dir/fzf"

# gnupg
mkdir -p "$HOME/.gnupg"
link_prompt "$DIR/gnupg/gpg-agent.conf" "$HOME/.gnupg/gpg-agent.conf"

# bash keybindings
keybindings_dir=$HOME/.local/share/bash-keybinding/keybindings
mkdir -p "$keybindings_dir"
link_prompt "$DIR/bash/keybindings/fzf" "$keybindings_dir/fzf"

# windows
if [[ "$(uname)" == MINGW* ]]; then
    link_prompt "$DIR/mintty/minttyrc" "$HOME/.minttyrc"
else
    # tmux
    link_prompt "$DIR/tmux/tmux.conf" "$HOME/.tmux.conf"

    # X
    link_prompt "$DIR/x/Xdefaults" "$HOME/.Xdefaults"

    # X Scripts
    mkdir -p "$HOME/.local/bin"
    link_prompt "$DIR/x/scripts/pixlock" "$HOME/.local/bin/pixlock"
    link_prompt "$DIR/x/scripts/monitorlayout" "$HOME/.local/bin/monitorlayout"
    link_prompt "$DIR/x/scripts/ranger-open" "$HOME/.local/bin/ranger-open"

    # Images
    mkdir -p "$HOME/Images"
    link_prompt "$DIR/x/images/lock.png" "$HOME/Images/lock.png"

    # i3
    mkdir -p "$HOME/.config/i3"
    link_prompt "$DIR/x/i3/config" "$HOME/.config/i3/config"
    link_prompt "$DIR/x/i3/i3status.conf" "$HOME/.config/i3/i3status.conf"

    # rofi-pass
    mkdir -p "$HOME/.config/rofi-pass"
    link_prompt "$DIR/x/rofi-pass/config" "$HOME/.config/rofi-pass/config"

    # dunst
    mkdir -p "$HOME/.config/dunst"
    link_prompt "$DIR/x/dunst/dunstrc" "$HOME/.config/dunst/dunstrc"

    # gtk
    link_prompt "$DIR/x/gtk/gtkrc-2.0" "$HOME/.gtkrc-2.0"
    link_prompt "$DIR/x/gtk/gtkrc-3.0" "$HOME/.config/gtk-3.0/settings.ini"
fi

if [ -n "$NEW" ]; then
    echo
    echo "New files:"
    echo -e $NEW
fi

if [ -n "$REPLACED" ]; then
    echo
    echo "Replaced files:"
    echo -e $REPLACED
fi

if [ -n "$SKIPPED" ]; then
    echo
    echo "Skipped files:"
    echo -e $SKIPPED
fi

echo
