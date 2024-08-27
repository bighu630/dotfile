#!/bin/bash
local=$(pwd)
git pull

backup_and_link() {
    source_file=$1
    target=$2
    backup_suffix=".bak"

    # 检查目标是否存在且不是软链接
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "Backing up $target to $target$backup_suffix"
        mv "$target" "$target$backup_suffix"
    fi

    # 创建符号链接
    ln -s -b "$source_file" "$target"
}

##### zsh
backup_and_link "$local/zshrc" "$HOME/.zshrc"
backup_and_link "$local/zshrc-alias" "$HOME/.zshrc-alias"
backup_and_link "$local/oh-my-zsh" "$HOME/.oh-my-zsh"

##### vim
backup_and_link "$local/nvim" "$HOME/.config/nvim"
backup_and_link "$local/vim" "$HOME/.vim"

##### config
backup_and_link "$local/config/mpd" "$HOME/.config/mpd"
backup_and_link "$local/config/ncmpcpp" "$HOME/.config/ncmpcpp"
backup_and_link "$local/config/picom" "$HOME/.config/picom"
backup_and_link "$local/config/ranger" "$HOME/.config/ranger"
backup_and_link "$local/config/rofi" "$HOME/.config/rofi"
backup_and_link "$local/alacritty" "$HOME/.config/alacritty"

##### tmux
backup_and_link "$local/tmux/.tmux.conf.local" "$HOME/.tmux.conf.local"
backup_and_link "$local/tmux/.tmux.conf" "$HOME/.tmux.conf"

##### 杂项
backup_and_link "$local/conkyrc" "$HOME/.conkyrc"
backup_and_link "$local/autostart.sh" "$HOME/.autostart.sh"
