autoload colors; colors

export CLICOLOR=1

LS_COLORS="di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32"
LSCOLORS=Cxgacxdxbxegedabagacad

if ls --color -d . &>/dev/null 2>&1
then
    # Linux
    export LS_COLORS=$LS_COLORS
    alias ls="ls --color=yes"
else
    # BSD
    export LSCOLORS=$LSCOLORS
fi

if [ -x ~/.vim/bundle/gruvbox/gruvbox_256palette.sh ]; then
    source ~/.vim/bundle/gruvbox/gruvbox_256palette.sh
fi

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
