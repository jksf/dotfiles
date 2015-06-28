#!/bin/bash

if (( ${BASH_VERSION%%.*} < 4 )) ; then
    >&2 echo "Requires Bash version 4 or higher"
    exit 1
fi

set -e

SCRIPT=`realpath $0`
DIR=`dirname $SCRIPT`
BACKUP_DIR="$HOME/.dotfiles-backup"
NEW=
REPLACED=
SKIPPED=

link_prompt() {
    if [ -e $2 ]; then
        read -r -p "replace ‘$2’? y(es)|b(ackup)|no: "
        if [[ ${REPLY,,} =~ ^y(es)?$ ]]; then
            rm -rf $2
            ln -sf $1 $2
            REPLACED="$REPLACED\n$2"
        elif [[ ${REPLY,,} =~ ^b(ackup)?$ ]]; then
            mkdir -p "$BACKUP_DIR"
            mv $2 "$BACKUP_DIR"
            ln -sf $1 $2
            BACKUPED="$BACKUPED\n$2"
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
link_prompt "$DIR/git/cvsignore" "$HOME/.cvsignore"

# emacs
link_prompt "$DIR/emacs/spacemacs" "$HOME/.spacemacs"

# fish
mkdir -p "$DIR/fish"
link_prompt "$DIR/fish/config.fish" "$HOME/.config/fish/config.fish"
link_prompt "$DIR/fish/fishfile" "$HOME/.config/fish/fishfile"

# print summary
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

if [ -n "$BACKUPED" ]; then
    echo
    echo "Replaced with backup in $BACKUP_DIR:"
    echo -e $BACKUPED
fi

if [ -n "$SKIPPED" ]; then
    echo
    echo "Skipped files:"
    echo -e $SKIPPED
fi

echo
