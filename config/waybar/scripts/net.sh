#!/bin/bash

# 自动检测活跃网卡
ethn=""
for iface in /sys/class/net/*; do
    name=$(basename "$iface")
    [[ "$name" == "lo" ]] && continue
    [[ -d "/sys/class/net/$name/device" ]] && ethn="$name" && break
done

if [[ -z "$ethn" ]]; then
    echo "↓0 B/s ↑0 B/s"
    exit 0
fi

# 读取一次数据（差值由 waybar 的 interval 控制，显示瞬时速度参考）
# 但为了显示实际网速，用 /proc/net/dev 两次读法，但去掉内部 sleep
# 这里改成「读取累积量，自行缓存前一秒值」的模式

CACHE_FILE="/dev/shm/waybar_net_${ethn}"

read_bytes() {
    cat /proc/net/dev | grep "$ethn" | sed 's/:/ /g' | awk '{print $2, $10}'
}

current=$(read_bytes)
rx_cur=$(echo "$current" | awk '{print $1}')
tx_cur=$(echo "$current" | awk '{print $2}')

if [[ -f "$CACHE_FILE" ]]; then
    read -r rx_old tx_old < "$CACHE_FILE"
    rx_diff=$((rx_cur - rx_old))
    tx_diff=$((tx_cur - tx_old))
else
    rx_diff=0
    tx_diff=0
fi

echo "$rx_cur $tx_cur" > "$CACHE_FILE"

format() {
    local val=$1
    if [[ $val -lt 1024 ]]; then
        echo "0 B/s"
    elif [[ $val -gt 1048576 ]]; then
        awk "BEGIN {printf \"%3.1fM\", $val/1048576}"
    else
        awk "BEGIN {printf \"%4.1fK\", $val/1024}"
    fi
}

echo "↓$(format $rx_diff) ↑$(format $tx_diff)"
