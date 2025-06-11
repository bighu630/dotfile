#!/bin/bash
git pull
git submodule update --init --recursive
git submodule foreach git add .
git submodule foreach git commit -m "Update submodule"
git submodule foreach 'git push'
git add .
git commit -m "Update submodules"
git push

 notify-send "update" -i "dcc_nav_update" -u low
