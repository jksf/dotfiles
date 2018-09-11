alias g=git

# Set up SSH authentication using GPG keys
gpgconf --launch gpg-agent
set -e SSH_AUTH_SOCK
set -U -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
