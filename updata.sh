git pull
cp -rf $HOME/.zshrc zshrc
cp -rf $HOME/.zshrc-alias zshrc-alias
cp -rf $HOME/.oh-my-zsh/* oh-my-zsh
cp -rf $HOME/.vim/* vim
cp -rf $HOME/.config/nvim/* nvim
cp -rf $HOME/.config/ncmpcpp/* config/ncmpcpp
cp -rf $HOME/.config/mpd/* config/mpd
cp -rf $HOME/.config/rofi/* config/rofi
cp -rf $HOME/.config/ranger config/ranger
cp -rf $HOME/.config/picom config/picom
cp -rf $HOME/.tmux.conf tmux/.tmux.conf
cp -rf $HOME/.tmux.conf.local tmux/.tmux.conf.local
git add *
git commit -m "update"
git push
