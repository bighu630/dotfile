# 书签添加工具使用说明

这个Python脚本可以帮你快速添加书签到startpage，自动下载网站的favicon图标。

## 安装依赖

```bash
pip install -r requirements.txt
```

## 使用方法

### 方法1: 命令行模式

```bash
python add_bookmark.py <网址> <列数> [-n 自定义名称] [-p 行数]
```

**参数说明：**
- `网址`: 要添加的网站URL (可以省略 https://)
- `列数`: 添加到第几列 (1-4，对应页面上的4列书签)
- `-n`: 可选，自定义网站显示名称
- `-p`: 可选，插入到第几行 (从1开始计数，默认添加到末尾)

**示例：**
```bash
# 添加GitHub到第1列
python add_bookmark.py github.com 1

# 添加Stack Overflow到第2列，自定义名称
python add_bookmark.py stackoverflow.com 2 -n "Stack Overflow"

# 添加到第3列的第1行（插入到最前面）
python add_bookmark.py example.com 3 -p 1

# 添加到第2列的第3行
python add_bookmark.py github.com 2 -p 3 -n "GitHub"

# 添加完整URL到第3列末尾
python add_bookmark.py https://www.example.com 3
```

### 方法2: 交互模式

直接运行脚本，按提示输入：

```bash
python add_bookmark.py
```

脚本会逐步询问：
1. 网址
2. 列数 (1-4)
3. 插入位置 (可选，默认末尾)
4. 自定义名称 (可选)

**交互示例：**
```
请输入网址: github.com
请输入列数 (1-4): 1
插入到第几行 (可选，按回车添加到末尾): 2
自定义网站名称 (可选，按回车跳过): GitHub
```

## 功能特性

### 🎯 自动功能
- **自动获取网站标题**: 解析网页title标签作为书签名称
- **智能favicon检测**: 自动查找多种favicon格式
  - `<link rel="icon">`
  - `<link rel="shortcut icon">`
  - `<link rel="apple-touch-icon">`
  - `/favicon.ico` (默认位置)
- **安全文件名**: 自动生成安全的图标文件名
- **重复检测**: 如果图标已存在会询问是否覆盖

### 📁 文件组织
- 图标保存到 `icons/` 文件夹
- 文件名格式: `网站名.ico`
- 自动更新 `index.html`

### 🛡️ 错误处理
- 网络超时处理
- 无效URL自动修正
- favicon下载失败时的优雅降级
- HTML解析错误处理

## 列数说明

startpage有4列书签，每列可以有多行：

```
列1      列2        列3       列4
----    ------    -------   --------
新闻类   区块链类   媒体类    开发工具类

行数控制：
- 不指定行数：添加到列的末尾
- 指定行数1：插入到列的最前面  
- 指定行数N：插入到第N行位置
```

## 生成的HTML格式

脚本会生成如下格式的HTML：

```html
<li>
    <a href="https://example.com" target="_blank">
        <img src="icons/example.ico" 
             class="favicon" 
             alt="Example favicon" />
        Example
    </a>
</li>
```

## 故障排除

### 常见问题

**1. 无法下载favicon**
- 检查网络连接
- 某些网站可能阻止爬虫访问
- 脚本会尝试多个favicon URL

**2. 网站名称不准确**
- 使用 `-n` 参数自定义名称
- 或在交互模式中手动输入

**3. 列数超出范围**
- 目前支持1-4列
- 检查 `index.html` 中的书签结构

**4. 中文网站处理**
- 脚本支持中文网站
- 自动处理UTF-8编码

## 注意事项

1. **备份重要**: 建议在修改前备份 `index.html`
2. **网络要求**: 需要能访问目标网站
3. **权限要求**: 需要对 `icons/` 目录和 `index.html` 的写入权限
4. **浏览器缓存**: 添加后可能需要刷新浏览器缓存

## 示例运行过程

```bash
$ python3 add_bookmark.py
=== 书签添加工具 ===
按 Ctrl+C 随时退出

==================================================
请输入网址: github.com
请输入列数 (1-4): 1
插入到第几行 (可选，按回车添加到末尾): 2
自定义网站名称 (可选，按回车跳过): 

开始添加书签...
正在处理URL: https://github.com
检测到网站名称: GitHub
网站名称 [GitHub] (按回车确认或输入新名称): 
尝试下载favicon: https://github.com/favicon.ico
✓ 成功下载favicon: github.ico
✓ 成功添加书签到第1列

🎉 成功添加书签:
   名称: GitHub
   URL: https://github.com
   列数: 1
   位置: 第2行
   图标: github.ico

是否继续添加其他书签? (Y/n): n
```

## 快速开始

1. 安装依赖：
   ```bash
   pip3 install -r requirements.txt
   ```

2. 运行脚本：
   ```bash
   # 交互模式
    python3 add_bookmark.py
   
   # 命令行模式 - 添加到末尾
   python3 add_bookmark.py github.com 1
   
   # 命令行模式 - 插入到指定位置
   python3 add_bookmark.py github.com 1 -p 2
   
   # 完整示例 - 所有参数
   python3 add_bookmark.py stackoverflow.com 2 -n "Stack Overflow" -p 1
   ```

## 实用技巧

1. **批量添加书签**：创建一个包含多个命令的脚本
   ```bash
   #!/bin/bash
   python3 add_bookmark.py github.com 1 -n "GitHub"
   python3 add_bookmark.py stackoverflow.com 1 -n "Stack Overflow"
   python3 add_bookmark.py reddit.com 1 -n "Reddit"
   ```

2. **重新排序书签**：使用 `-p` 参数将重要网站置顶
   ```bash
   # 将常用网站移到第1行
   python3 add_bookmark.py important.com 1 -p 1
   ```

3. **按类别组织**：
   - 第1列：新闻资讯类
   - 第2列：开发工具类  
   - 第3列：娱乐媒体类
   - 第4列：工作相关类