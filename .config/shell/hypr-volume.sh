#!/usr/bin/env bash

# 配置区
iDIR="$HOME/.config/mako/icons"
NOTIFY_CMD="notify-send -h string:x-canonical-private-synchronous:sys-notify -u low"

# 统一图标映射逻辑
get_icon() {
    local val=$1
    local prefix=$2
    if [ "$val" -eq 0 ]; then echo "$iDIR/${prefix}-mute.png"
    elif [ "$val" -le 30 ]; then echo "$iDIR/${prefix}-low.png"
    elif [ "$val" -le 60 ]; then echo "$iDIR/${prefix}-mid.png"
    else echo "$iDIR/${prefix}-high.png"; fi
}

# 动作执行区
case "$1" in
    --inc)        pamixer -i 5 ;;
    --dec)        pamixer -d 5 ;;
    --toggle)     pamixer -t ;;
    --toggle-mic) pamixer --default-source -t ;;
    --mic-inc)    pamixer --default-source -i 5 ;;
    --mic-dec)    pamixer --default-source -d 5 ;;
    *) echo "$(pamixer --get-volume)"; exit 0 ;;
esac

# 统一通知区
# 判断当前是操作音量还是麦克风
if [[ "$1" == *mic* ]]; then
    mic_vol=$(pamixer --default-source --get-volume)
    if [ "$(pamixer --default-source --get-mute)" == "true" ]; then
        $NOTIFY_CMD -i "$iDIR/microphone-mute.png" "Microphone Switched OFF"
    else
        $NOTIFY_CMD -i "$iDIR/microphone.png" "Mic-Level : $mic_vol%"
    fi
else
    vol=$(pamixer --get-volume)
    if [ "$(pamixer --get-mute)" == "true" ]; then
        $NOTIFY_CMD -i "$iDIR/volume-mute.png" "Volume Switched OFF"
    else
        $NOTIFY_CMD -i "$(get_icon "$vol" "volume")" "Volume : $vol%"
    fi
fi