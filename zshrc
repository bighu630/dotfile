# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="mytheme"

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
source ~/.zshrc-alias

#npm配置
# 定义npm存放的目录
#NPM_PACKAGES="${HOME}/.npm-packages"
## 确保node可以找到安装的包
#NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
## 确保可以使用安装的二进制应用和man文档
#PATH="$NPM_PACKAGES/bin:$PATH"
## Unset manpath so we can inherit from /etc/manpath via the `manpath`
## command
#unset MANPATH # delete if you already modified MANPATH elsewhere in your config
#MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# echo "何期自性本自清净！何期自性本不生灭！何期自性本自具足！何期自性本无动摇！何期自性能生万法！"
# /data/pyfile/read

export WINEARCH=win64
export WINEDEBUG=-all
export WINEPREFIX=~/公共/wine
#wien64 的配置可以使用wine64快是的使用deepin-wine5来模拟一个64位windows环境

# go语言配置
export GOROOT=/home/ivhu/.go
export GOPATH=/data/code/Go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$GOPATH/bin
#sudo go快捷键使用sgo可以直接运行需要管理员权限的go代码
#
#

#本地bin
export PATH=$PATH:/home/ivhu/.local/bin
export PATH=$PATH:/home/ivhu/.cargo/bin
export PATH=$PATH:/home/ivhu/.local/share/gem/ruby/3.0.0/bin

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

function connect_3_51()
{
    tmux rename-window 3.51
    ssh fabric@192.168.3.51
}

function connect_1_20()
{
    tmux rename-window 1.20
    sshpass -p "hfcas1-1=0" fabric@192.168.1.20
}

下班 ()
{

}

function work(){
    connect_3_51
    tmux new-window
    connect_1_20
    tmux new-window
    tmux rename-window local
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
export PATH=$PATH:/home/ivhu/.local/share/nvim/mason/bin
export TERM=xterm-256color

#自定义
#限制频率60%

# 将大写锁定改为esc
function setkeymod1 ()
{
    setxkbmap
    xmodmap ~/.xmodmap
}

#代理
function proxy_on() {
    export http_proxy=http://192.168.3.244:7890
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
# enable auto-suggestions based on the history
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#f9f899'
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export EDITOR=/usr/bin/nvim

# alias cd='cdWithZ'

# if [ -n "$DESKTOP_SESSION" ];then
#     eval $(gnome-keyring-daemon --start)
#     export SSH_AUTH_SOCK
# fi

eval "$(zoxide init zsh)"
export PATH="$PATH:/home/ivhu/.foundry/bin"
source /home/ivhu/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ==GVC== block start
# sub block @gvc start
export  PATH="$PATH:$HOME/.gvc"
# sub block @gvc end
___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"; if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi
. "/home/ivhu/.acme.sh/acme.sh.env"

printf '\eP$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "zsh" }}\x9c'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "/home/ivhu/.bun/_bun" ] && source "/home/ivhu/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
