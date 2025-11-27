#!/bin/bash

# 提取当前播放歌曲的文件路径
song=$(mpc --format "%file%" current)

song=~/音乐/$song

# 提取封面图片，存为临时文件
cover_image=$(mktemp -u /tmp/mpd_cover_XXXXXX.png)

ffmpeg -i "$song" -an -v quiet -map_metadata 0 -f image2pipe -c:v png "$cover_image"

# 发送带封面的通知
notify-send "MPD is playing" "$(mpc current)" -i "$cover_image"

# 删除临时封面文件
rm "$cover_image"
