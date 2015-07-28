#!/bin/bash

SCRIPT=`realpath $0`
DIR=`dirname $SCRIPT`

ln -s $DIR/git/gitconfig $HOME/.gitconfig
ln -s $DIR/tmux/tmux.conf $HOME/.tmux.conf
ln -s $DIR/zsh/zshrc $HOME/.zshrc
ln -s $DIR/vim/vimrc $HOME/.vimrc
ln -s $DIR/vim/gvimrc $HOME/.gvimrc

ln -s $DIR/zsh $HOME/.zsh
ln -s $DIR/vim $HOME/.vim
