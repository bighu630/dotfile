#!/bin/bash
git pull
commitMSG=$1

# 提交所有嵌套仓库的更改
for dir in $(find . -maxdepth 2 -name ".git" | xargs dirname); do
	echo "Processing $dir"
	cd $dir
	git pull
	git add .
	git commit -m "update $dir"
	git push
	cd - >/dev/null
done

git add .
if [ -z "$1" ]; then
	git commit -m "update ."
else
	git commit -m "$1"
	notify-send "auto upload dotfile" -i "dcc_nav_update" -u low
fi
git push
