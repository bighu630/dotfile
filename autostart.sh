#!/bin/bash

picoms &

xmodmap ~/.xmodmap &

gnome-keyring-daemon --start &

kwalletd6 &

export SSH_AUTH_SOCK

fcitx5 &

# xfce4-power-manager &

kdeconnect-indicator &

xfce4-clipman &

redshift-gtk &

keynav &

# plasma-browser-integration-host &
# klipper &
# volumeicon &

blueman-applet &

nm-applet &

feh --recursive --randomize --bg-fill /home/ivhu/图片/壁纸/bg-d & # 69.png
# feh --recursive --randomize --bg-fill /home/ivhu/图片/壁纸/plasma6/*
/home/ivhu/dotfiles/scripts/autolock.sh &

# /usr/lib/xfce4/notifyd/xfce4-notifyd &
# dunst &
lxqt-notificationd &

# /data/server/frp_0.53.2_linux_amd64/frpc -c /data/server/frp_0.53.2_linux_amd64/frpc.toml &

conky &

# yakuake &

# dwmblocks &

# aw-qt &

# utools &

cd $DOTFILE/dwm || exit

./statusbar/statusbar.sh cron &

sleep(3)

/usr/lib/polkit-kde-authentication-agent-1 &
