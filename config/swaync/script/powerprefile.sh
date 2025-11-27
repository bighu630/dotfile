mode=$1
if [ $mode = "performance" ];then
    powerprofilesctl set performance
    notify-send "性能模式"
elif [ $mode = "balanced" ];then
    powerprofilesctl set balanced
    notify-send "平衡模式"
elif [ $mode = "powersave" ];then
    powerprofilesctl set power-saver
    notify-send "节能模式"
fi

echo $mode
