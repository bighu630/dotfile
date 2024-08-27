#!/bin/bash
local=$(pwd)
git pull
###### zsh
rm -rf $HOME/.oh-my-zsh-bak
ln -s -b $local/zshrc $HOME/.zshrc
ln -s -b $local/zshrc-alias $HOME/.zshrc-alias
ln -s -b $local/oh-my-zsh $HOME/.oh-my-zsh

##### vim
rm -rf $HOME/.config/nvim-bak
rm -rf $HOME/.vim-bak
# mv $HOME/.vim $HOME/.vim-bak
# mv $HOME/.config/nvim $HOME/.config/nvim-bak
ln -s -b ${local}/nvim ~/.config
ln -s -b ${local}/vim ~/.vim

##### config
cp -rf config/* $HOME/.config

##### tmux
mv $HOME/.tmux.conf $HOME/.tmux.conf.bak
mv $HOME/.tmux.conf.local $HOME/.tmux.conf.local.bak
cp -rf tmux/.tmux.conf $HOME
cp -rf tmux/.tmux.conf.local $HOME

#### 杂项
#
cp -rf ./conkyrc $HOME/.conkyrc
cp -rf ./autostart.sh $HOME/.autostart.sh
