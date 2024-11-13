#!/bin/bash

cd $HOME/dotfile
WATCH_DIR=$HOME/dotfile

./update.sh

while true; do
    # 使用inotifywait监控文件夹中的变化
    inotifywait -r -e modify,create,delete,move "$WATCH_DIR" | while read -r path action file; do
        sleep 60
        ./update.sh
    done
done
