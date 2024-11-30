#!/bin/bash
git pull
commitMSG=$1

checkUpdate() {
    if git status --porcelain | grep -q '^[ M]'; then
        echo 1
        return
    fi
    LOCAL=$(git rev-parse @)
    REMOTE=$(git rev-parse "$(git rev-parse --abbrev-ref @{upstream})")

    # 比较本地和远程的提交
    if [ "$LOCAL" == "$REMOTE" ]; then
        echo 0
        return
    fi
    echo 1
}

update() {
	echo "Processing $dir"
	cd $dir
    if [ "$(checkUpdate)" == "0" ]; then
        continue
    fi
	git pull
	git add .
	git commit -m "update $dir"
	git push
}

# 提交所有嵌套仓库的更改
for dir in $(find . -mindepth 2 -maxdepth 2 -name ".git" | xargs dirname); do
    update &
done


sleep 3


if [ "$(checkUpdate)" == "0" ];then
    exit
fi
git add .
if [ -z "$1" ]; then
	git commit -m "update ."
else
	git commit -m "$1"
	notify-send "auto upload dotfile" -i "dcc_nav_update" -u low
fi
git push
