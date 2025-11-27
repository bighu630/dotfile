#!/bin/bash

process_name=$1  # 要判断的进程名

# 使用 ps 命令获取所有进程信息
pgrep -x $process_name > /dev/null 2>&1

# 判断进程是否存在
if [ $? -eq 0 ]; then
    pkill -9 $process_name
else
    $process_name
fi
