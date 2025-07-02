
# 清除从 Git 索引中所有以 ranger/ranger 开头的子模块
find .git/modules/ranger/ranger -type d -name '*' | while read path; do
  submodule_path="${path#.git/modules/}"  # 去掉前缀
  if [ -d "$submodule_path" ]; then
    git rm --cached "$submodule_path" 2>/dev/null
    rm -rf "$submodule_path"
  fi
  rm -rf "$path"
done

# 删除 .gitmodules 中所有 ranger/ranger 的配置
sed -i '/submodule "ranger\/ranger/,/^$/d' .gitmodules

# 可选：删除 git config 中的对应记录
git config -f .git/config --remove-section submodule.ranger/ranger 2>/dev/null
