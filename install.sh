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
    ln -s -b -T "$source_file" "$target"
}

backup_and_link_dirs(){
    source_dir=$1
    target_dir=$2
    backup_suffix=".bak"

    # 确保目标目录存在
    mkdir -p "$target_dir"

    # 遍历原文件夹中的所有一级文件夹
    for dir in "$source_dir"/*/; do
        # 获取目录名
        dir_name=$(basename "$dir")

        # 目标文件夹路径
        target="$target_dir/$dir_name"

        # 检查目标是否存在且不是软链接
        if [ -e "$target" ] && [ ! -L "$target" ]; then
            echo "Backing up $target to $target$backup_suffix"
            mv "$target" "$target$backup_suffix"
        fi

        # 创建符号链接
        ln -s -f -T "$dir" "$target"
    done
}

##### zsh
backup_and_link "$local/zshrc" "$HOME/.zshrc"
backup_and_link "$local/zshrc-alias" "$HOME/.zshrc-alias"
backup_and_link "$local/oh-my-zsh" "$HOME/.oh-my-zsh"

##### vim
backup_and_link "$local/nvim" "$HOME/.config/nvim"
backup_and_link "$local/vimrc" "$HOME/.vim"

##### config
backup_and_link_dirs "$local/config" "$HOME/.config"

##### tmux
backup_and_link "$local/tmux/.tmux.conf.local" "$HOME/.tmux.conf.local"
backup_and_link "$local/tmux/.tmux.conf" "$HOME/.tmux.conf"

##### 杂项
backup_and_link "$local/conkyrc" "$HOME/.conkyrc"
backup_and_link "$local/autostart.sh" "$HOME/.autostart.sh"
