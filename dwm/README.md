# DWM YES

yaocccc README

dwm 是一个非常快速, 小巧并使用动态管理窗口的窗口管理器

[展示视频: BV1Ef4y1Z7kA](https://www.bilibili.com/video/BV1Ef4y1Z7kA/)

## 功能

- 支持布局 tile(磁块)、magicgrid(进阶的网格布局)
- 键盘移动/调整窗口大小 且移动/调整时有窗口间吸附效果
- 窗口隐藏
- 窗口可自定义是否全局(在所有tag内展示)
- 更好的浮动窗口支持
- 优化后的status2d 状态栏，可用鼠标点击操作
- 系统托盘支持
- overview
- mod + tab, 在窗口间切换 有浮动窗口时仅在浮动窗口切换
- mod + [tag], 切换tag到指定目录时 可指定一个cmd，若目标tag无窗口 则执行该tag

## 安装

```plaintext
  !!!首次使用 请 cp -r DEF/* .

  每次修改源代码后都需要执行
  sudo make clean install
```

## !!!运行 dwm!!!

请确保你已配置 ~/.xinitrc 文件, DWM指向你的dwm仓库所在路径

```plaintext
export DWM=~/workspace/dwm
exec dwm
```

tty中执行 `startx` 启动

如果想在tty1中自动执行startx可在你的bash或zsh配置中添加

```plaintext
  [ $(tty) = "/dev/tty1" ] && cd ~ && startx
```

## !!!关于fork配置!!!

```plaintext
  本仓库默认集成了 `DEF/` 目录，该目录为作者本人使用的配置
  DEF: 推荐配置 亦是 作者本人使用的配置

  首次运行 可自行 `cp -r DEF/* .`

  后续请用户自行维护 ./config.h ./statusbar ./autostart.sh 文件
  且此部分文件已被 gitignore

  即用户可始终保持yaocccc/dwm仓库代码最新版而不受影响

  较推荐的fork方式

  1. fork本代码仓库
  2. 自行维护fork后的仓库相关的配置文件: ./config.h ./statusbar ./autostart.sh
  3. 注释掉fork后仓库中 .gitignore 的前三行
  4. 定期在github页面sync yaocccc/dwm 仓库保持最新
```

### Nix Flake

下面是在 nixos configuration 中使用它的示例

```nix
{
  description = "My configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    dwm.url = "github:yaocccc/dwm";
  };

  outputs = { nixpkgs, dwm, ... }:
    {
      nixosConfigurations = {
        hostname = nixpkgs.lib.nixosSystem
          {
            system = "x86_64-linux";
            modules = [
              {
                nixpkgs.overlays = [ dwm.overlays.default ];
              }
            ];
          };
      };
    };
}
```

## 状态栏

请将每一个块置为下列样式, 可直接使用本仓库statusbar相关脚本 或参考使用

```plaintext
  ^sdate^^c#2D1B46^^b#335566^  11/04 00:42 ^d^

  ^s?????^ => 点击时的信号值
  ^c?????^ => 前景色
  ^b?????^ => 背景色
  ^d^      => 重置颜色

  也可以直接从^c ^b 定义前景色 后景色透明度
  ^c#??????0xff^ => 0xff 前景色透明度
  ^b#??????0x11^ => 0x11 后景色透明度

  本仓库维护了 statusbar脚本 入口为 ./statusbar/statusbar.sh

  模块列表见 ./statusbar/packages

  若需要使用 请逐个去查看 修改packages中的脚本文件

  请在dwm启动时 调用 $DWM/statusbar/statusbar.sh cron

  注意 ~/.profile中需要有 该环境变量为强依赖关系
  export DWM=~/workspace/dwm

  点击事件发生时 会调用 $DWM/statusbar/statusbar.sh 并传入信号值 请自行处理
  例如 $DWM/statusbar/statusbar.sh date L  # 其中date为信号值 L为按键 (L左键 M中键 R右键)

  可执行 $DWM/statusbar/statusbar.sh check 检查是否有模块存在问题
```

## 随DWM启动的自启动命令

dwm启动时会去调用 $DWM/autostart.sh 脚本

可参考 [autostart脚本](https://github.com/yaocccc/dwm/blob/master/DEF/autostart.sh)

## Q & A

1. 如何启动dwm？

确保 ~/.xinitrc 中有 exec dwm。在tty中使用 startx 命令启动

2. 进入后是黑屏啥都没

壁纸需要用类似feh的软件设置 `feh --randomize --bg-fill ~/pictures/*.png`

3. 打不开终端

务必先修改config.h中启动终端的快捷键，本项目的config.h是我自用的配置 你需要手动修改

例如 可以修改以下部分(如果你用的终端是st的话)

```plaintext
    /* spawn + SHCMD 执行对应命令 */
    { MODKEY,              XK_Return,       spawn,            SHCMD("st") },
```

4. 字体显示不全

请自行安装字体 仅以archlinux举例

```shell
yay -S nerd-fonts-jetbrains-mono
yay -S ttf-material-design-icons
yay -S ttf-joypixels
yay -S wqy-microhei
```

5. 如果想使用tabbed管理st

推荐以下按键配置

关联链接
[极简终端: https://github.com/yaocccc/st](https://github.com/yaocccc/st)
[多tab管理: https://github.com/yaocccc/st](https://github.com/yaocccc/tabbed)

```c
    { MODKEY,              XK_s,      togglescratch, SHCMD("tabbed -n scratchpad -c -r 2 st -w ''") },          /* super s          | 打开st scratchpad      */
    { MODKEY,              XK_Return, spawn, SHCMD("tabbed -n st -C tabbed -c -r 2 st -w ''") },                /* super enter      | 打开st                 */
    { MODKEY,              XK_minus,  spawn, SHCMD("tabbed -n st -C FG -c -r 2 st -w ''") },                    /* super +          | 打开全局st终端         */
    { MODKEY,              XK_space,  spawn, SHCMD("tabbed -n st -C float -c -r 2 st -w ''") },                 /* super space      | 打开浮动st终端         */
```

6. 为什么我的st各种奇怪问题

可以考虑先用我的 [yaocccc/st](https://github.com/yaocccc/st)

7. 自启动脚本没启动

请检查DWM变量是否正确设置，如果实在不行了，可以直接强制改config.h 里的 autostartscript 和 statusbarscript 变量
