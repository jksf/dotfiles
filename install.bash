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
link_prompt $DIR/git/gitconfig $HOME/.gitconfig

# vim
link_prompt $DIR/vim/vimrc $HOME/.vimrc
link_prompt $DIR/vim/gvimrc $HOME/.gvimrc
link_prompt $DIR/vim $HOME/.vim

# bash
link_prompt $DIR/bash/bashrc $HOME/.bashrc
link_prompt $DIR/bash/bash_profile $HOME/.bash_profile
link_prompt $DIR/bash/inputrc $HOME/.inputrc
link_prompt $DIR/bash/git-completion.bash $HOME/.git-completion.bash

# windows
if [[ "$(uname)" == MINGW* ]]; then
    link_prompt $DIR/mintty/minttyrc $HOME/.minttyrc
else
    # screen
    link_prompt $DIR/screen/screenrc $HOME/.screenrc

    # X
    link_prompt $DIR/x/Xdefaults $HOME/.Xdefaults
    link_prompt $DIR/x/xsessionrc $HOME/.xsessionrc

    # X Scripts
    mkdir -p $HOME/bin
    link_prompt $DIR/x/scripts/pixlock $HOME/bin/pixlock
    link_prompt $DIR/x/scripts/monitorlayout $HOME/bin/monitorlayout
    link_prompt $DIR/x/scripts/ranger-open $HOME/bin/ranger-open

    # Images
    mkdir -p $HOME/Images
    link_prompt $DIR/x/images/lock.png $HOME/Images/lock.png

    # i3
    mkdir -p $HOME/.config/i3
    link_prompt $DIR/x/i3/config $HOME/.config/i3/config
    link_prompt $DIR/x/i3/i3status.conf $HOME/.config/i3/i3status.conf

    # dunst
    mkdir -p $HOME/.config/dunst
    link_prompt $DIR/x/dunst/dunstrc $HOME/.config/dunst/dunstrc

    # gtk
    link_prompt $DIR/x/gtk/gtkrc-2.0 $HOME/.gtkrc-2.0
    link_prompt $DIR/x/gtk/gtkrc-3.0 $HOME/.config/gtk-3.0/settings.ini
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
