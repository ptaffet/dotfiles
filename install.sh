#!/bin/bash

if [ -f $HOME/.bashrc ]; then
    rm -i $HOME/.bashrc
fi

if [ -f $HOME/.vimrc ]; then
    rm -i $HOME/.vimrc
fi

#TODO: Make this robust to cloning to a directory other than dotfiles
ln -s $HOME/dotfiles/.bashrc $HOME/.bashrc
ln -s $HOME/dotfiles/.vimrc $HOME/.vimrc

ln -s $HOME/dotfiles/localsettings $HOME/localsettings
git update-index --skip-worktree $HOME/localsettings/.bashrc

# ln -s $HOME/dotfiles/ssh_config $HOME/.ssh/config
