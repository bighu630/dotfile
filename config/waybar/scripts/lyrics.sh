#!/bin/bash

SOCKET_PATH="/tmp/lyrics_app.sock"
FIFO_PATH="/tmp/waybar_lyrics_fifo"

# 创建命名管道
[ ! -p "$FIFO_PATH" ] && mkfifo "$FIFO_PATH"

# 检查并启动后台持久连接
if ! pgrep -f "socat.*lyrics_app.*waybar_lyrics" > /dev/null; then
    # 清理可能存在的旧连接
    pkill -f "socat.*lyrics_app.*waybar_lyrics" 2>/dev/null

    # 启动持久连接（后台运行）
    nohup socat UNIX-CONNECT:$SOCKET_PATH PIPE:$FIFO_PATH > /dev/null 2>&1 &

    # 等待连接建立
    sleep 0.1
fi

# 读取最新歌词（非阻塞）
LYRICS=$(timeout 0.1 cat "$FIFO_PATH" 2>/dev/null | tail -n 1)

if [ -n "$LYRICS" ] && [ "$LYRICS" != "Waiting for lyrics..." ]; then
    if [ ${#LYRICS} -gt 50 ]; then
        echo "♪ ${LYRICS:0:47}..."
    else
        echo "♪ $LYRICS"
    fi
else
    echo "♪"
fi
