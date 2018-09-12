# dotfiles

My development environment configuration.

## Installation

Fetch git submodules

```
git submodule update --init --recursive
```

Run `./install.bash`. The installation script will prompt before replacing any existing files.

## Troubleshooting

### Gnome Keyring overriding `SSH_AUTH_SOCK`

Turn off SSH component in `/etc/xdg/autostart/gnome-keyring-ssh.desktop`

```diff
-Exec=/usr/bin/gnome-keyring-daemon --start --components=ssh
+Exec=/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets
```

### Glitches in Spacemacs Powerline

Install `unifont`, for example:

```
sudo apt install ttf-unifont
```
