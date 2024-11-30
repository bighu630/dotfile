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
    ln -s -f -T "$source_file" "$target"
}

# 遍历文件夹
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

hyprlandCfg(){
    if [ ! -f "config/hypr/configs/env_hidpi.conf" ];then
        touch config/hypr/configs/env_hidpi.conf  # 只需要文件存在就可以，如果有配置可以写在这里面
    fi
}

oh-my-zshCfg(){
    # 判断目录不存在
    if [ -d "./oh-my-zsh/plugins/zsh-autosuggestions" ]; then
        echo "zsh-autosuggestions已存在"
    else
        git clone https://github.com/zsh-users/zsh-autosuggestions ./oh-my-zsh/plugins/zsh-autosuggestions
    fi

    if [ -d "./oh-my-zsh/plugins/zsh-syntax-highlighting" ]; then
        echo "oh-my-zsh-plugins已存在"
    else
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ./oh-my-zsh/plugins/zsh-syntax-highlighting
    fi
}


##### zsh
backup_and_link "$local/zshrc" "$HOME/.zshrc"
backup_and_link "$local/zshrc-alias" "$HOME/.zshrc-alias"
backup_and_link "$local/oh-my-zsh" "$HOME/.oh-my-zsh"

##### vim
backup_and_link "$local/nvim" "$HOME/.config/nvim"
backup_and_link "$local/vimrc" "$HOME/.vim"

##### .config
backup_and_link_dirs "$local/config" "$HOME/.config"

#### .local/share
backup_and_link_dirs "$local/share" "$HOME/.local/share"

##### tmux
backup_and_link "$local/tmux/.tmux.conf.local" "$HOME/.tmux.conf.local"
backup_and_link "$local/tmux/.tmux.conf" "$HOME/.tmux.conf"

##### 杂项
backup_and_link "$local/conkyrc" "$HOME/.conkyrc"
backup_and_link "$local/autostart.sh" "$HOME/.autostart.sh"

hyprlandCfg
oh-my-zshCfg

if [ -f .install.sh ];then
    ./.install.sh
fi
