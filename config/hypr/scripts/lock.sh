#!/bin/bash

# 检查是否有媒体正在播放
if playerctl status 2>/dev/null | grep -q "Playing"; then
    exit
else
    OUTPUT=$(pactl list sink-inputs)

    # 初始化变量
    CORKED_LINE=0
    NODE_NAME_LINE=0
    LINE_NUMBER=0

    # 读取输出并查找行号
    while IFS= read -r line; do
        ((LINE_NUMBER++))

        if [[ "$line" == *"Corked: no"* ]]; then
            CORKED_LINE=$LINE_NUMBER
        elif [[ "$line" == *'node.name = "cn.xfangfang.wiliwili"'* || "$line" == *'node.name = "mpv"'* ]]; then
            NODE_NAME_LINE=$LINE_NUMBER
        fi
    done <<< "$OUTPUT"

    # 检查行号差异
    if [[ $CORKED_LINE -gt 0 && $NODE_NAME_LINE -gt 0 ]]; then
        DIFF=$((NODE_NAME_LINE - CORKED_LINE - 1))

        if [[ $DIFF -eq 10 ]]; then
            echo 0
        else
            swayidle -w timeout 1799 'systemctl suspend'
            pgrep hyprlock || hyprlock
        fi
    else
        swayidle -w timeout 1799 'systemctl suspend' &
        pgrep hyprlock || hyprlock
    fi
fi
