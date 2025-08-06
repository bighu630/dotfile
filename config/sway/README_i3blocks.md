# Sway + i3blocks 状态栏配置

这是一个为 Sway 窗口管理器配置的 i3blocks 状态栏设置，包含了多个实用的系统监控模块。

## 功能特性

### 📊 系统监控模块
- **CPU 使用率** - 显示当前 CPU 使用百分比，颜色根据负载变化
- **内存使用** - 显示内存使用情况 (已用/总计)
- **系统负载** - 显示 1 分钟平均负载
- **磁盘使用** - 显示根分区磁盘使用情况
- **温度监控** - 显示 CPU 温度，高温时自动警告

### 🔋 硬件状态
- **电池状态** - 显示电池电量、充电状态，低电量时紧急提醒
- **音量控制** - 显示当前音量，支持点击控制和滚轮调节
- **WiFi 状态** - 显示 WiFi 连接状态、信号强度和 SSID

### 🎵 媒体与时间
- **媒体播放器** - 支持 MPD 和 playerctl，显示当前播放状态
- **天气信息** - 显示当前天气状况（可选，需要 API 密钥）
- **日期时间** - 显示当前日期和时间

## 安装依赖

### 必需的软件包
```bash
# Arch Linux / Manjaro
sudo pacman -S i3blocks pulseaudio-utils

# Ubuntu / Debian
sudo apt install i3blocks pulseaudio-utils

# Fedora
sudo dnf install i3blocks pulseaudio-utils
```

### 可选软件包（用于增强功能）
```bash
# 系统监控工具
sudo pacman -S htop sensors lm_sensors

# 媒体播放器支持
sudo pacman -S mpd mpc playerctl

# 网络管理
sudo pacman -S networkmanager

# 天气信息（需要 curl 和 jq）
sudo pacman -s curl jq
```

## 配置文件说明

### 主配置文件
- `i3blocks.conf` - i3blocks 主配置文件
- `config` - Sway 配置文件（已修改 bar 部分）

### 脚本文件 (`bin/bar.d/`)
- `battery` - 电池状态监控
- `cpu_usage` - CPU 使用率监控
- `disk` - 磁盘使用监控
- `load_average` - 系统负载监控
- `mediaplayer` - 媒体播放器状态
- `memory` - 内存使用监控
- `temperature` - 温度监控
- `volume` - 音量控制
- `weather` - 天气信息（可选）
- `wifi` - WiFi 状态监控

## 使用方法

### 1. 启动配置
配置已经在 Sway 主配置文件中设置，重新加载 Sway 配置即可：
```bash
swaymsg reload
```

### 2. 切换状态栏显示
使用快捷键 `Mod+Shift+B` 来切换状态栏的显示/隐藏。

### 3. 交互功能

#### 音量控制
- **左键点击**: 静音/取消静音
- **右键点击**: 打开音量控制面板 (pavucontrol)
- **滚轮上下**: 音量增减 5%

#### 内存/CPU 监控
- **左键点击**: 打开 htop 系统监控
- **右键点击**: 显示详细信息

#### 电池状态
- **左键点击**: 显示详细电池信息
- **右键点击**: 打开电源管理设置

#### WiFi 状态
- **左键点击**: 打开网络管理器 (nmtui)
- **右键点击**: 显示详细 WiFi 信息

#### 媒体播放器
- **左键点击**: 播放/暂停
- **中键点击**: 停止播放
- **右键点击**: 打开音乐播放器
- **滚轮上**: 上一首
- **滚轮下**: 下一首

#### 天气信息
- **左键点击**: 打开天气网站
- **右键点击**: 刷新天气数据

## 自定义配置

### 修改模块顺序
编辑 `i3blocks.conf` 文件，调整模块的顺序：
```ini
# 将你想要的模块按顺序排列
[cpu_usage]
[memory]
[disk]
# ...
```

### 修改颜色主题
在各个脚本中修改颜色值，或者在 `i3blocks.conf` 中设置：
```ini
[module_name]
color=#ff5555  # 红色
color=#50fa7b  # 绿色
color=#8be9fd  # 蓝色
```

### 调整更新间隔
在 `i3blocks.conf` 中修改 `interval` 值：
```ini
[cpu_usage]
interval=5  # 每5秒更新一次
```

### 添加天气功能
1. 注册 OpenWeatherMap API: https://openweathermap.org/api
2. 编辑 `bin/bar.d/weather` 脚本
3. 在 `API_KEY=""` 处填入你的 API 密钥
4. 修改 `CITY` 变量为你的城市名

### 自定义网络接口
如果你的 WiFi 接口不是 `wlan0`，可以在配置中指定：
```ini
[wifi]
instance=wlp3s0  # 替换为你的网络接口名
```

## 故障排除

### 模块不显示
1. 检查脚本是否有执行权限：
   ```bash
   chmod +x ~/.config/sway/bin/bar.d/*
   ```

2. 检查依赖软件是否已安装

3. 查看 i3blocks 日志：
   ```bash
   journalctl --user -f | grep i3blocks
   ```

### 音量控制不工作
确保 PulseAudio 正在运行：
```bash
systemctl --user status pulseaudio
```

### WiFi 状态显示 N/A
1. 检查网络接口名称：
   ```bash
   ip link show
   ```
2. 更新配置中的接口名称

### 电池信息不显示
检查电池路径是否存在：
```bash
ls /sys/class/power_supply/
```

## 主题颜色参考

当前使用的是 Dracula 主题颜色：
- 背景: `#282a36`
- 前景: `#f8f8f2`
- 红色: `#ff5555`
- 绿色: `#50fa7b`
- 黄色: `#f1fa8c`
- 蓝色: `#8be9fd`
- 紫色: `#bd93f9`
- 橙色: `#ffb86c`

## 贡献

如果你有改进建议或发现了 bug，欢迎提交 issue 或 pull request。

## 许可证

此配置基于 MIT 许可证发布。