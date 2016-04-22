#!/bin/bash

SCRIPT=`realpath $0`
DIR=`dirname $SCRIPT`

ln -s $DIR/git/gitconfig $HOME/.gitconfig
ln -s $DIR/tmux/tmux.conf $HOME/.tmux.conf
ln -s $DIR/zsh/zshrc $HOME/.zshrc
ln -s $DIR/vim/vimrc $HOME/.vimrc
ln -s $DIR/vim/gvimrc $HOME/.gvimrc
ln -s $DIR/mintty/minttyrc $HOME/.minttyrc
ln -s $DIR/bash/bashrc $HOME/.bashrc
ln -s $DIR/bash/bash_profile $HOME/.bash_profile
ln -s $DIR/bash/git-completion.bash $HOME/.git-completion.bash

ln -s $DIR/zsh $HOME/.zsh
ln -s $DIR/vim $HOME/.vim
