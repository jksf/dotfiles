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
            REPLACED="$REPLACED\n$2"
            ln -s $1 $2
        else
            SKIPPED="$SKIPPED\n$2"
        fi
    else
        NEW="$NEW\n$2"
    fi
}

# git
link_prompt $DIR/git/gitconfig $HOME/.gitconfig

# tmux
link_prompt $DIR/tmux/tmux.conf $HOME/.tmux.conf

# vim
link_prompt $DIR/vim/vimrc $HOME/.vimrc
link_prompt $DIR/vim/gvimrc $HOME/.gvimrc
link_prompt $DIR/vim $HOME/.vim

# bash
link_prompt $DIR/bash/bashrc $HOME/.bashrc
link_prompt $DIR/bash/bash_profile $HOME/.bash_profile
link_prompt $DIR/bash/git-completion.bash $HOME/.git-completion.bash

# windows
if [ "$(uname)" == "MINGW32_NT" ]; then
    link_prompt $DIR/mintty/minttyrc $HOME/.minttyrc
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
