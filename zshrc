# ============================================================
#  ZSH 配置 - 优化版
#  优化项目:
#  - 修复 zsh-autosuggestions / zsh-syntax-highlighting 双重加载
#  - 懒加载 thefuck / zoxide / omp (省 ~3.8s)
#  - 跳过 compaudit 和终端 title 更新 (省 ~12ms)
# ============================================================

export ZSH=$HOME/.oh-my-zsh

# --- 性能优化选项 (必须在 source oh-my-zsh.sh 之前) ---
ZSH_DISABLE_COMPFIX=true    # 跳过 compaudit 权限检查 (省 ~10ms)
DISABLE_AUTO_TITLE=true     # 跳过终端标题更新 (省 ~2ms)

# --- Oh My Zsh 主题 ---
ZSH_THEME="mytheme"

# --- Oh My Zsh 插件 ---
# 注意: zsh-autosuggestions / zsh-syntax-highlighting 不在 plugins 里，
# 而是在底部手动 source (syntax-highlighting 必须在 compinit 之后加载)。
plugins=(
    colored-man-pages
    colorize
    cp
    git
    vi-mode
)

source $ZSH/oh-my-zsh.sh

# --- 别名 ---
source ~/.zshrc-alias

# --- API Key 配置 ---
source ~/.zsh_ai
source ~/.zsh_api.zsh

# ============================================================
#  PATH 与环境变量
# ============================================================

# --- npm 配置 ---
NPM_PACKAGES="${HOME}/.npm-packages"
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
PATH="$NPM_PACKAGES/bin:$PATH"
unset MANPATH
MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
# 注意: npm config set prefix 只需执行一次，不需要每次 shell 都运行
# 手动执行: npm config set prefix '~/.npm-packages'

# --- Wine 配置 ---
export WINEARCH=win64
export WINEDEBUG=-all
export WINEPREFIX=~/公共/wine

# --- Go 语言配置 ---
export GOROOT=${HOME}/.go
export GOPATH=/data/GO/GOPATH
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# --- JAVA 配置 ---
export JAVA_HOME=/usr/lib/jvm/default
export PATH=$PATH:$JAVA_HOME/bin
export JDTLS_HOME=$HOME/.local/share/nvim/lsp_servers/java/
export WORKSPACE=$HOME/.local/share/nvim/lsp_servers/java/workspace/

# --- 本地 bin 路径 ---
export PATH=$PATH:${HOME}/.local/bin:${HOME}/.cargo/bin
export PATH=$PATH:${HOME}/.local/share/gem/ruby/3.0.0/bin
export PATH=$PATH:/data/pyfile
export PATH=$PATH:${HOME}/.local/share/nvim/mason/bin
export PATH=$PATH:/home/ivhu/.bun/bin
export PATH="$PATH:${HOME}/.foundry/bin"

export TERM=xterm-256color
export EDITOR=/usr/bin/nvim

# --- Java 版本切换函数 ---
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

# --- 其他工具函数 ---
function sayhello() { /data/pyfile/read }

function connect_3_51() {
    tmux rename-window 3.51
    ssh fabric@192.168.3.51
}
function connect_1_20() {
    tmux rename-window 1.20
    sshpass -p "hfcas1-1=0" fabric@192.168.1.20
}
function work(){
    connect_3_51
    tmux new-window
    connect_1_20
    tmux new-window
    tmux rename-window local
}

# --- 键盘设置 ---
function setkeymod1 () {
    setxkbmap
    xmodmap ~/.xmodmap
}

# --- 代理函数 ---
function proxy_on() {
    export http_proxy=http://192.168.3.244:7890
    export https_proxy=$http_proxy
    echo -e "终端代理已开启。"
}
function proxy_off(){
    unset http_proxy https_proxy
    echo -e "终端代理已关闭。"
}
function go_proxy(){
    export GOPROXY=https://proxy.golang.com.cn,direct
    export GOPRIVATE=git.mycompany.com,github.com/my/private
    echo -e "GO代理已开启。"
}

SWITCH_ALT_WIN () {
    local conf=~/.config/hypr/configs/env_hidpi.conf
    if grep -q "altwin:swap_lalt_lwin" "$conf" 2>/dev/null; then
        sed -i 's/,altwin:swap_lalt_lwin//' "$conf"
    else
        sed -i 's/caps:escape/caps:escape,altwin:swap_lalt_lwin/' "$conf"
    fi
}

# --- fzf ---
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ============================================================
#  懒加载: 首次使用时才初始化 (省 ~3.8s 启动时间)
# ============================================================

# --- zoxide (预先加载) ---
unalias z 2>/dev/null
eval "$(zoxide init zsh)"

# thefuck 已移除 (启动太慢)

# --- omp completions 懒加载 (省 ~1.5s) ---
# omp 命令很少交互使用，按 Tab 时才生成补全
if (( $+commands[omp] )); then
  function _omp() {
    unfunction _omp
    eval "$(omp completions zsh 2>/dev/null)"
    _omp "$@"
  }
  compdef _omp omp
fi

# ============================================================
#  插件底层加载 (必须在 compinit 之后)
#  zsh-autosuggestions 必须在 zsh-syntax-highlighting 之前
# ============================================================
source ~/.oh-my-zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
