#!/bin/bash
# filepath: /data/code/lyrics/waybar_lyrics.sh
LYRICS=$(timeout 0.01 socat UNIX-CONNECT:/tmp/lyrics_app.sock STDOUT 2>/dev/null | tail -n 1)
if [ -n "$LYRICS" ] && [ "$LYRICS" != "Waiting for lyrics..." ]; then
    # 限制长度为50字符（与你的C++代码一致）
    if [ ${#LYRICS} -gt 50 ]; then
        echo "♪ ${LYRICS:0:47}..."
    else
        echo "♪ $LYRICS"
    fi
else
    echo "♪"
fi
