git pull
cp -rf $HOME/.zshrc zshrc
cp -rf $HOME/.zshrc-alias zshrc-alias
cp -rf $HOME/.oh-my-zsh oh-my-zsh
cp -rf $HOME/.vim vim
cp -rf $HOME/.config/nvim nvim
cp -rf $HOME/.config/ncmpcpp config/
cp -rf $HOME/.config/mpd config/
cp -rf $HOME/.config/rofi config/
cp -rf $HOME/.config/ranger config/
cp -rf $HOME/.config/picom config/
cp -rf $HOME/.tmux.conf tmux/.tmux.conf
cp -rf $HOME/.tmux.conf.local tmux/.tmux.conf.local
git add *
git commit -m "update"
git push
