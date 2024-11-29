#!/bin/bash
cd ~/dotfile
# 监听的目录
WATCH_DIR="~/dotfile"

# 死循环监听
while true; do
    sleep 600  # 10min自动同步到github
    ./update.sh autoUpdate
done
