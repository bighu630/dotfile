#!/bin/bash

# 获取窗口 ID
pid=$(pgrep -x "bluetuith")

# 判断窗口是否存在
if [ -n "$pid" ]; then
    # 杀死窗口
    pkill -f "bluetuith"
else
    xfce4-terminal --title bluetui  --geometry 70x20 -e bluetuith
fi
