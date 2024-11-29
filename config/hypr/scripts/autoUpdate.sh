#!/bin/bash
cd ~/dotfile

while true; do
    sleep 600  # 10min自动同步到github
    ./update.sh autoUpdate
done
