#!/bin/bash

HISTFILE="$HOME/.local/share/rofi-surf-history.txt"
mkdir -p "$(dirname "$HISTFILE")"
touch "$HISTFILE"

URL=$(cat "$HISTFILE" | sort | uniq | rofi -dmenu -p "Enter URL" -l 10)

# 如果用户取消了输入，则退出
[ -z "$URL" ] && exit 0

# 自动添加 https:// 前缀（如果没有）
if ! [[ "$URL" =~ ^https?:// ]]; then
    URL="https://$URL"
fi

# 记录历史（避免重复）
grep -Fxq "$URL" "$HISTFILE" || echo "$URL" >> "$HISTFILE"

# 使用 surf 打开
GDK_BACKEND=x11 surf "$URL" &
