# DotFile

![look](https://s2.loli.net/2025/01/03/Nt2gp9HYs3Ax7Zy.png)

## assembly list

### 桌面环境

- hyprland
- hyprlock
- hypridle
- waybar
- swasync
- rofi-wayland
- kitty
- swww
- qutebrowser
- grim
- [swappy](https://github.com/bighu630/swappy)
- slurp
- wlogout
- networkmanager
- [bluetuith](https://github.com/darkhz/bluetuith)
- kde connect
- fcitx5
- kvantummanager
- wlsunset
- pavucontrol-qt
- bottom
- axel
- git
- [daed](https://github.com/daeuniverse/daed)([v2raya](https://github.com/v2rayA/v2rayA))
- tmux
- zsh
- qt6ct(qt6ct-kde)
- yazi
- cliphist(copyq)
- swayidle
- lsd
- swaync
- fcitx5-configtool
- fcitx5-chinese-addons
- nwg-look
- tlp
- archlinux-xdg-menu

### vim 依赖

- neovim
- vim
- nodejs
- fzf
- jq
- fd
- ripgrep
- lazygit
- yarn
- prettier
- wl-clipboard

## 其他软件(不用安装)

- vscode
- wiliwili
- wechat
- qqlinux
- telegram-desktop(我选择用网页版的)
- youtube-music-desktop
- wine
- meilmaster(网易邮箱大师，目前只能用wine版本的)
- krdc
- bruno(轻量postman)
- konsole
- dolphin
- keepassxc
- wps
- obs
- trilium

## 工具

- ksystemlog # 日志查看
- nitrogen # 壁纸切换
- nwg-display # 显示器管理
- syncthing
- aliyundrive-webdav-bin
- keepassxc
- power-profiles-daemon
- neovide
- oklur

## install in arch

```shell
yay -S hyprland hyprlock waybar swaylock rofi-wayland kitty qutebrowser networkmanager bluetuith wlogout kdeconnect fcitx5 wlsunset pavucontrol-qt bottom axel git daed tmux zsh qt6ct-kde yazi neovim vim nodejs fzf jq ripgrep fd kvantummanager lazygit swww grim swappy slurp cliphist swayidle lsd swaync fcitx5-configtool fcitx5-chinese-addons nwg-look tlp archlinux-xdg-menu hypridle
# fcitx5 词库，可以不用安装
yay -S fcitx5-pinyin-chinese-idiom fcitx5-pinyin-sougou fcitx5-pinyin-zhwiki fcitx5-pinyin-custom-pinyin-dictionary

# neovim
yay -S yarn nodejs prettier wl-clipboard

# 常用工具
yay -S ksystemlog nitrogen nwg-display syncthing aliyundrive-webdav-bin keepassxc power-profiles-daemon neovide oklur
```

> 如果有人在配置文件中找到了我的翻译程序😄，那么需要一个配置文件，[可以在这里找到配置文件怎么获取](https://github.com/bighu630/translate-tui),放在这个翻译程序相同的路径 ,快捷键是（ALT+Shift+s）

## use

```bash
git clone --recursive https://github.com/bighu630/dotfile.git
mv dotfile ~ #dotfile 必须放在用户目录下，如果要修改需要修改用户dotfile目录下所有的 `~/dotfile`
cd ~/dotfile
./install.sh
```

### hyprland安装必要插件

> 由于我配置文件配了这几个hyprland插件相关的东西，所以这几个插件必须安装(或者可以删除对应的配置)

```shell
yay -S cmake meson cpio pkg-config
hyprpm update
hyprpm add https://github.com/hyprwm/hyprland-plugins
hyprpm add https://github.com/Duckonaut/split-monitor-workspaces
# hyprpm add https://github.com/outfoxxed/hy3  # 用不管hy3
hyprpm add https://github.com/bighu630/hycov
hyprpm add https://github.com/KZDKM/Hyprspace
hyprpm add https://github.com/pyt0xic/hyprfocus
# hyprpm enable hy3
hyprpm enable hycov
hyprpm enable Hyprspace
hyprpm enable hyprexpo
hyprpm enable hyprfocus
hyprpm enable split-monitor-workspaces
```

## 添加内容

eg: 我想要自动同步 ~/.config/mpd 这个文件夹里面的内容

```sh
cd dotfile/config
mv ~/.config/mpd .
cd ..
./install.sh # 创建本地的软连接
./updata.sh # 上传到github
```

> 注意不能同步 ~/.config/mpd/playlists/ 这种目录，只能同步config目录下的一级目录
> 也可以同步单个文件

### WRAN

非常不建议同步share目录中的内容，可能包含个人信息

### 一些有用的网址（有些东西yay里面没有，就只能手动安装了,主要是一些主题文件）

- [gtk-theme](https://github.com/vinceliuice/WhiteSur-gtk-theme)
