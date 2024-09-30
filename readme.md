# DotFile

## assembly list

### 桌面环境

- hyprland
- waybar
- swasync
- rofi
- kitty
- qutebrowser
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
- ranger

### vim 依赖

- nvim
- vim
- nodejs
- fzf
- jq
- fd
- rigrep
- lazygit

## install in arch

```shell
yay -S hyprland waybar swaylock rofi kitty qutebrowser networkmanager bluetuith kdeconnect fcitx5 wlsunset pavucontrol-qt bottom axel git daed tmux zsh qt6ct ranger neovim vim nodejs fzf jq rigrep fd kvantummanager lazygit

```

> 如果有人在配置文件中找到了我的翻译程序😄，那么需要一个配置文件，[可以在这里找到配置文件怎么获取](https://github.com/bighu630/translate-tui),放在这个翻译程序相同的路径 ,快捷键是（ALT+Shift+s）

## use

```
git clone --recursive https://github.com/bighu630/dotfile.git
cd dotfile
./install.sh
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
