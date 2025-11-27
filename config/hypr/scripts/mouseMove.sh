#!/bin/bash

# 检查参数是否存在
if [ -z "$1" ]; then
    echo "Usage: $0 <direction>"
    echo "Directions: l (left), h (right), j (down), k (up)"
    exit 1
fi

# 获取当前鼠标位置
cursor_pos=$(hyprctl cursorpos)
current_x=$(echo "$cursor_pos" | awk -F', ' '{print $1}')
current_y=$(echo "$cursor_pos" | awk -F', ' '{print $2}')

# 根据方向计算新坐标
case "$1" in
    l) new_x=$((current_x + 10)); new_y=$current_y ;;
    h) new_x=$((current_x - 10)); new_y=$current_y ;;
    j) new_x=$current_x; new_y=$((current_y + 10)) ;;
    k) new_x=$current_x; new_y=$((current_y - 10)) ;;
    *)
        echo "Invalid direction: $1"
        echo "Valid directions: l (left), h (right), j (down), k (up)"
        exit 1
        ;;
esac

# 执行鼠标移动
hyprctl dispatch movecursor "$new_x $new_y"
