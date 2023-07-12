# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH=$HOME/.oh-my-zsh
export OPENAI_API_KEY=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

ZSH_THEME="robbyrussell"

plugins=(    
	colored-man-pages
    colorize
	git
	vi-mode
	z
    cp
    zsh-autosuggestions
	zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh


#npm配置
# 定义npm存放的目录
NPM_PACKAGES="${HOME}/.npm-packages"
# 确保node可以找到安装的包
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
# 确保可以使用安装的二进制应用和man文档
PATH="$NPM_PACKAGES/bin:$PATH"
# Unset manpath so we can inherit from /etc/manpath via the `manpath`
# command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
MANPATH="$NPM_PACKAGES/share/man:$(manpath)"


# echo "何期自性本自清净！何期自性本不生灭！何期自性本自具足！何期自性本无动摇！何期自性能生万法！"
# /data/pyfile/read

export WINEARCH=win32
export WINEPREFIX=~/.wine
#wien64 的配置可以使用wine64快是的使用deepin-wine5来模拟一个64位windows环境
alias www="export WINEARCH=win64 WINEPREFIX=~/公共/wine"
alias ww="export WINEARCH=win32 WINEPREFIX=~/.wine"
alias deepin="WINEARCH=win64 WINEPREFIX=~/.deepinwine deepin-wine6-stable"
alias keymod="echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode"

# go语言配置
export GOROOT=/home/bighu/.go
export GOPATH=/data/code/Go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$GOPATH/bin
#sudo go快捷键使用sgo可以直接运行需要管理员权限的go代码
alias sgo='sudo /home/bighu/.go/bin/go'

#本地bin
export PATH=$PATH:/home/bighu/.local/bin
export PATH=$PATH:/home/bighu/.cargo/bin
export PATH=$PATH:/home/bighu/.local/share/gem/ruby/3.0.0/bin

function setjava11() {
    sudo rm /usr/lib/jvm/default
    sudo ln -s /usr/lib/jvm/java-11-openjdk /usr/lib/jvm/default
}

function setjava17() {
    sudo rm /usr/lib/jvm/default
    sudo ln -s /usr/lib/jvm/java-17-openjdk /usr/lib/jvm/default
}
function setjava20() {
    sudo rm /usr/lib/jvm/default
    sudo ln -s /usr/lib/jvm/java-20-openjdk /usr/lib/jvm/default
}

function sayhello(){
    /data/pyfile/read
}

下班 ()
{
    echo "下班打卡"
}

# sayhello

#install JAVA JDK
#java jdk路径
export JAVA_HOME=/usr/lib/jvm/default
export PATH=$PATH:$JAVA_HOME/bin
export JDTLS_HOME=$HOME/.local/share/nvim/lsp_servers/java/ 			# 包含 plugin 和 configs 的目录，由jdt-language-server-xxx.tar.gz解压出的
export WORKSPACE=$HOME/.local/share/nvim/lsp_servers/java/workspace/ # 不设置则默认是$HOME/workspace
# export JRE_HOME=/data/jdk/jdk-17/jre
# export CLASS_PATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib
# export PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin
# export JAVA_HOME JRE_HOME CLASS_PATH PATH
# alias upjava="sudo update-alternatives --config java"
#py的环境变量
export PATH=$PATH:/data/pyfile

#natron的环境变量,这是一个视频特效软件,现在应该是没什么用
export PATH=$PATH:/data/natron

#fabric的工具包的环境变量
export PATH=$PATH:/data/文档/区块链/fabric-samples/bin

export PATH=$PATH:/opt/cuda/bin
export LD_LIBRARY_PATH=/opt/cuda/lib

#自定义
#限制频率60%
alias c="echo "hutendalo" | echo "60" | sudo tee /sys/devices/system/cpu/intel_pstate/max_perf_pct"
alias cc="echo "50" | sudo tee /sys/devices/system/cpu/intel_pstate/max_perf_pct"
alias ncp="echo "100" | sudo tee /sys/devices/system/cpu/intel_pstate/max_perf_pct"

#更换壁纸,在dwm下用的,kde时一般不使用这个
alias bg="feh --recursive --randomize --bg-fill /data/图片/壁纸/bg-d/*"

# alias yay=sayhello

#方便使用python3
alias py='python3'
#下载工具
alias ad='aria2c'
# --dir=~/下载/aria2'
# 终端文件管理
alias ra='ranger'
# 使用一种更新的cat
alias cat='bat'
# 带有图标的ls
alias ls='lsd'
#连接服务器
# alias server='ssh -i ~/.ssh/id_rsa -p 22 ivhu@39.103.230.97'
# alias ssh='kitty +kitten ssh'
# alias diff='kitty +kitten diff'
#清屏
alias cl='clear'
#退出
alias q='exit'
#使用代理
alias d='proxychains'
# 开启clash
alias ca='~/公共/clash/clash.sh'
#v2ray
alias va='/home/bighu/公共/clash/va.sh'
#使用fzf搜索文件
alias cdf='cd $(find * -type d | fzf)'
#使用fzf打开文件
alias vimf='nvim $(fzf)'
# 修改rm命令将文件删除至回收站
alias rm=trash-put
alias rl=trash-list
alias cp='cp -r'
alias gdl="cd ~/.gvc&&./gvc xray shell"

alias tmuxsw="tmux set -g status"

# 将大写锁定改为esc
function setkeymod1 ()
{
    setxkbmap
    xmodmap ~/.xmodmap
}

# 蓝牙键盘专用
function setkeymod2 ()
{
    setxkbmap
    xmodmap ~/.xmodmap2
}

alias mod1=setkeymod1
alias mod2=setkeymod2

#代理
function proxy_on() {
    export http_proxy=http://127.0.0.1:7890
    export https_proxy=$http_proxy
    echo -e "终端代理已开启。"
}

# 默认开启代理
# export http_proxy=http://127.0.0.1:7890
# export https_proxy=$http_proxy

# 关闭终端代理
function proxy_off(){
    unset http_proxy https_proxy
    echo -e "终端代理已关闭。"
}

function go_proxy(){
    # 配置 GOPROXY 环境变量
    export GOPROXY=https://proxy.golang.com.cn,direct
    # 还可以设置不走 proxy 的私有仓库或组，多个用逗号相隔（可选）
    export GOPRIVATE=git.mycompany.com,github.com/my/private
    echo -e "GO代理已开启。"
}
# alias dl='export http_proxy=http://127.0.0.1:7890 && export https_proxy=https://127.0.0.1:7890'
alias dl=proxy_on
alias ndl=proxy_off
alias godl=go_proxy

# alias wget='proxychains wget'
alias neo="neofetch | lolcat"


#快速打开笔记
alias vimm='cd /data/文档/md && vim .'

#切换到指定路经
alias cd="z"
alias cdd='cd /data/code/'
alias cds='cd ~/文档/区块链/src'
alias cdc='cd /data/code/cross'
alias cdr='cd ~/文档/区块链/fabric-Restaurant'
alias cdm='cd ~/文档/md'

#创造文件
alias mk='mkdir'

#burpsuite的启动方法
alias burpcn='cd /home/bighu/下载/burpcn && java -javaagent:BurpSuiteCn.jar -Xbootclasspath/p:burp-loader-keygen.jar  -Xmx1024m -jar burpsuite_pro_v1.7.37.jar'
alias burp='cd /home/bighu/下载/burp && /usr/lib/jvm/java-11-openjdk/bin/java -javaagent:BurpLoaderKeygen.jar -noverify -jar burpsuite_pro.jar'

#默认使用nvim
# alias vim="nvim"
#快速复制输出
alias x="xclip -selection c"
#打开自动启动脚本
alias auto='vim ~/公共/aliwebdav/auto.sh'

alias poweroff="下班 && mpc pause && sync && poweroff"
alias reboot="sync && reboot"
alias pg="pkill gopls"

# some more ls aliases
alias ll='lsd -l'
alias la='lsd -a'
alias l='lsd'
alias cp='cpv'


alias ydl="cd /data/音乐 && yt-dlp  -f 'ba' -x --audio-format mp3"
# enable auto-suggestions based on the history
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#f9f899'
fi

alias xmod="xmodmap ~/.xmodmap"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export EDITOR=/usr/bin/nvim

eval "$(zoxide init zsh)"
export PATH="$PATH:/home/bighu/.foundry/bin"
source /home/bighu/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ==GVC== block start
# sub block @gvc start
export  PATH="$PATH:$HOME/.gvc"
# sub block @gvc end
# ==GVC== block end
