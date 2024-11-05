git pull
#
#!/bin/bash

# 提交所有嵌套仓库的更改
for dir in $(find . -maxdepth 1 -name ".git" | xargs dirname); do
    echo "Processing $dir"
    cd $dir
    git pull
    git add .
    git commit -m "update $dir"
    git push
    cd - > /dev/null
done

git add *
git commit -m "update"
git push
