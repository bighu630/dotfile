# 不是马上执行
sleep 1
menu() {
    while true; do
        sleep 10

        XDG_MENU_PREFIX=arch- kbuildsycoca6
        sleep 30
    done
}

waybarUp() {
    while true; do
        sleep 10
        # 检查 waybar 是否正在运行
        if ! pgrep waybar > /dev/null; then
            # 如果 waybar 未运行，则启动它
            waybar &
        fi
    done
}

# waybarUp &
menu
