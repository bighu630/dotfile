git pull
###### zsh
rm -rf $HOME/.oh-my-zsh-bak
mv $HOME/.zshrc $HOME/.zshrc.bak
mv $HOME/.zshrc-alias $HOME/.zshrc-alias-bak
mv $HOME/.oh-my-zsh $HOME/.oh-my-zsh-bak
cp -rf zshrc $HOME/.zshrc
cp -rf zshrc-alias $HOME/.zshrc-alias
cp -rf oh-my-zsh $HOME/.oh-my-zsh

##### vim
rm -rf $HOME/.config/nvim-bak
rm -rf $HOME/.vim-bak
mv $HOME/.vim $HOME/.vim-bak
mv $HOME/.config/nvim $HOME/.config/nvim-bak
cp -rf vim $HOME/.vim
cp -rf nvim $HOME/.config/nvim

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
