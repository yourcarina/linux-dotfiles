#!/usr/bin/env bash

# 配置区
iDIR="$HOME/.config/mako/icons"
NOTIFY_CMD="notify-send -h string:x-canonical-private-synchronous:sys-notify -u low"
# 自动探测系统背光设备，若有多个取第一个
DEV=$(ls /sys/class/backlight/ | head -n 1)

# 统一图标映射逻辑
get_icon() {
    local percent=$1
    if [ "$percent" -le 30 ]; then echo "$iDIR/brightness-20.png"
    elif [ "$percent" -le 70 ]; then echo "$iDIR/brightness-60.png"
    else echo "$iDIR/brightness-100.png"; fi
}

# 动作执行区
case "$1" in
    --inc) brightnessctl -d "$DEV" set +10% ;;
    --dec) brightnessctl -d "$DEV" set 10%- ;;
    *) echo "$(brightnessctl -d "$DEV" g)"; exit 0 ;;
esac

# 统一通知区
val=$(brightnessctl -d "$DEV" g)
max=$(brightnessctl -d "$DEV" m)
percent=$(( val * 100 / max ))

$NOTIFY_CMD -i "$(get_icon "$percent")" "Screen Brightness : $percent%"