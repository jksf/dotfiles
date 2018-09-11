#!/bin/bash

if (( ${BASH_VERSION%%.*} < 4 )) ; then
    >&2 echo "Requires Bash version 4 or higher"
    exit 1
fi

set -e

dir="$(dirname "$(realpath "$0")")"
backup_dir="$HOME/.dotfiles-backup"

link_prompt() {
    if [ "$2" -ef "$1" ]; then
        symlinked+=("$2")
    elif [ -e "$2" ]; then
        read -r -p "replace ‘$2’? y(es)|b(ackup)|no: "
        if [[ ${REPLY,,} =~ ^y(es)?$ ]]; then
            rm -rf "$2"
            ln -sf "$1" "$2"
            replaced+=("$2")
        elif [[ ${REPLY,,} =~ ^b(ackup)?$ ]]; then
            mkdir -p "${backup_dir}"
            mv "$2" "${backup_dir}"
            ln -sf "$1" "$2"
            backedup+=("$2")
        else
            skipped+=("$2")
        fi
    else
        ln -sf "$1" "$2"
        new+=("$2")
    fi
}

print_files() {
    if [ -n "$2" ]; then
        echo
        echo "$1:"
        for file in "${@:2}"
        do
            echo "${file}"
        done
    fi
}

# profile
link_prompt "${dir}/profile" "$HOME/.profile"

# gnupg
mkdir -p "$HOME/.gnupg"
link_prompt "${dir}/gnupg/gpg.conf" "$HOME/.gnupg/gpg.conf"
link_prompt "${dir}/gnupg/gpg-agent.conf" "$HOME/.gnupg/gpg-agent.conf"

# git
link_prompt "${dir}/git/gitconfig" "$HOME/.gitconfig"
link_prompt "${dir}/git/cvsignore" "$HOME/.cvsignore"

# emacs
link_prompt "${dir}/emacs/spacemacs" "$HOME/.spacemacs"

# fish
mkdir -p "$HOME/.config/fish"
link_prompt "${dir}/fish/config.fish" "$HOME/.config/fish/config.fish"
link_prompt "${dir}/fish/fishfile" "$HOME/.config/fish/fishfile"

# print summary
print_files "New" "${new[@]}"
print_files "Replaced" "${replaced[@]}"
print_files "Replaced and backed up in ${backup_dir}" "${backedup[@]}"
print_files "Already symlinked" "${symlinked[@]}"
print_files "Skipped" "${skipped[@]}"
