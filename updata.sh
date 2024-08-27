git pull
cp -rf $HOME/.config/ncmpcpp/* config/ncmpcpp
cp -rf $HOME/.config/mpd/* config/mpd
cp -rf $HOME/.config/rofi/* config/rofi
cp -rf $HOME/.config/ranger config/ranger
cp -rf $HOME/.config/picom config/picom
cp -rf $HOME/.tmux.conf tmux/.tmux.conf
cp -rf $HOME/.tmux.conf.local tmux/.tmux.conf.local


#!/bin/bash

# 提交所有嵌套仓库的更改
for dir in $(find . -maxdepth 2 -name ".git" | xargs dirname); do
    echo "Processing $dir"
    cd $dir
    git add .
    git commit -m "update $dir"
    git push
    cd - > /dev/null
done

git add *
git commit -m "update"
git push
