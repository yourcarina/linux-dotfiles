#!/usr/bin/env bash

# 配置区
iDIR="$HOME/.config/mako/icons"
NOTIFY_CMD="notify-send -h string:x-canonical-private-synchronous:sys-notify -u low"
# 自动探测键盘背光设备，允许找不到设备时优雅处理
DEV=$(ls /sys/class/leds/ | grep 'kbd_backlight' | head -n 1)

# 统一图标映射逻辑
get_icon() {
    local val=$1
    if [ "$val" -le 1 ]; then echo "$iDIR/brightness-20.png"
    elif [ "$val" -le 2 ]; then echo "$iDIR/brightness-60.png"
    else echo "$iDIR/brightness-100.png"; fi
}

# 动作执行区
case "$1" in
    --inc) [ -n "$DEV" ] && brightnessctl -d "$DEV" set 33%+ ;;
    --dec) [ -n "$DEV" ] && brightnessctl -d "$DEV" set 33%- ;;
    --zero) [ -n "$DEV" ] && brightnessctl -d "$DEV" s 0% ;;
    --full) [ -n "$DEV" ] && brightnessctl -d "$DEV" s 100% ;;
    *) echo "$(brightnessctl -d "$DEV" g 2>/dev/null || echo 0)"; exit 0 ;;
esac

# 统一通知区
if [ -z "$DEV" ]; then
    $NOTIFY_CMD -i "dialog-error" "Keyboard" "设备不支持键盘背光"
else
    val=$(brightnessctl -d "$DEV" g)
    $NOTIFY_CMD -i "$(get_icon "$val")" "Keyboard Brightness : $val"
fi