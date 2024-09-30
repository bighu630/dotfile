#!/bin/bash

# 获取窗口 ID
pid=$(pgrep -x "bluetuith")

# 判断窗口是否存在
if [ -n "$pid" ]; then
    # 杀死窗口
    pkill -f "bluetuith"
else
    kitty --title bluetui --config ~/.config/kitty/tools.conf -e bluetuith
fi
