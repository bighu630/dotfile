#!/bin/bash
cd ~/dotfile
# 监听的目录
WATCH_DIR="~/dotfile"

# 要执行的脚本路径
SCRIPT="./updata.sh"


# 死循环监听
while true; do
    echo "[$(date)] Starting to monitor $WATCH_DIR"
    inotifywait -m -e modify,create,delete "$WATCH_DIR" 2>/dev/null | while read -r directory event file; do
        echo "[$(date)] Detected $event on $file in $directory"
        # 执行指定脚本，并将文件名和事件传递给它
        "$SCRIPT"
    done
    echo "[$(date)] inotifywait terminated unexpectedly. Restarting..."
    sleep 1  # 防止重启过于频繁
done
