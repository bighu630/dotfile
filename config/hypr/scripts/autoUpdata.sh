#!/bin/bash
cd $DOTFILE

while true; do
    sleep 600  # 10min自动同步到github
    ./update.sh autoUpdate
done
