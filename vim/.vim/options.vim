let mapleader =" "
"识别文件类型
filetype on
"按文件类型加载插件
filetype plugin on
"语法高亮
syntax enable
syntax on
"设置256色
set t_Co=256
"
set scrolloff=5
set noeb
set wrap
set showcmd
set wildmenu
set virtualedit=block,onemore
set number
set relativenumber
set cursorline
set hlsearch
set incsearch
set ignorecase
set nobackup            " 设置不备份
set noswapfile          " 禁止生成临时文件
set autoread
set autowrite
set foldmethod=indent " 开启代码折叠
set foldlevelstart=99
set nofoldenable
set mouse+=a
set shiftwidth=8
set softtabstop=8

set langmenu=zh_CN.UTF-8
set helplang=cn
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030

let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)
