alias g=git

# Set up Go environment
set -x GOPATH $HOME/go

if test -d $GOPATH/bin
    set -x PATH $PATH $GOPATH/bin
end

# Set up Password Store
set -x PASSWORD_STORE_CHARACTER_SET '!#%+23456789:=?@ABCDEFGHJKLMNPRSTUVWXYZabcdefghijkmnopqrstuvwxyz'
set -x PASSWORD_STORE_CHARACTER_SET_NO_SYMBOLS '23456789ABCDEFGHJKLMNPRSTUVWXYZabcdefghijkmnopqrstuvwxyz'
set -x PASSWORD_STORE_GENERATED_LENGTH 20
set -x PASSWORD_STORE_CLIP_TIME 15
