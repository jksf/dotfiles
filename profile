# set up Golang
if [ -d "$HOME/go" ]; then
    export GOPATH="$HOME/go"
    export PATH="$GOPATH/bin:$PATH"
fi

export GO111MODULE=on

# set up Password Store
export PASSWORD_STORE_CHARACTER_SET='!#%+23456789:=?@ABCDEFGHJKLMNPRSTUVWXYZabcdefghijkmnopqrstuvwxyz'
export PASSWORD_STORE_CHARACTER_SET_NO_SYMBOLS='23456789ABCDEFGHJKLMNPRSTUVWXYZabcdefghijkmnopqrstuvwxyz'
export PASSWORD_STORE_GENERATED_LENGTH=20
export PASSWORD_STORE_CLIP_TIME=15

# if running bash
if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# add local bin to PATH
if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi
