#!/bin/bash
ethn=wlan0
# while true
# do
RX_pre=$(cat /proc/net/dev | grep $ethn | sed 's/:/ /g' | awk '{print $2}')
TX_pre=$(cat /proc/net/dev | grep $ethn | sed 's/:/ /g' | awk '{print $10}')
sleep 1
RX_next=$(cat /proc/net/dev | grep $ethn | sed 's/:/ /g' | awk '{print $2}')
TX_next=$(cat /proc/net/dev | grep $ethn | sed 's/:/ /g' | awk '{print $10}')
RX=$((${RX_next} - ${RX_pre}))
TX=$((${TX_next} - ${TX_pre}))
if [[ $RX -lt 1024 ]]; then
        # RX="${RX}B/s"
        RX="0 B/s"
elif [[ $RX -gt 1048576 ]]; then
        RX=$(echo $RX | awk '{printf("%3.1f M/s",$1/1048576)}')
else
        RX=$(echo $RX | awk '{printf("%4.1f K/s",$1/1024)}')
fi

if [[ $TX -lt 1024 ]]; then
        # TX="${TX}B/s"
        TX=" 0 B/s"
elif [[ $TX -gt 1048576 ]]; then
        TX=$(echo $TX | awk '{printf("%3.1f M/s",$1/1048576)}')
else
        TX=$(echo $TX | awk '{printf("%4.1f K/s",$1/1024)}')
fi
#echo -e "🌈↓$RX | ↑$TX "
echo -e "↓$RX ↑$TX"
