#!/bin/sh

# 截图保存路径（自动创建目录，避免报错）
SAVE_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SAVE_DIR"

# 生成带时间戳的文件名
FILENAME="Screenshot_$(date +%Y%m%d_%H%M%S).png"
SAVE_PATH="$SAVE_DIR/$FILENAME"

# 根据参数执行不同截图逻辑
case "$1" in
    --full)
        # 全屏截图
        grim "$SAVE_PATH" && notify-send "Screenshot --Full" "已保存：$SAVE_PATH"
        ;;
    --area)
        # 区域截图
        grim -g "$(slurp)" "$SAVE_PATH" && notify-send "Screenshot --Area" "已保存：$SAVE_PATH"
        ;;
    --edit)
        # 区域截图并编辑（先保存原文件，再传递给swappy）
        grim -g "$(slurp)" "$SAVE_PATH" && swappy -f "$SAVE_PATH" && notify-send "Screenshot --Edit" "原始文件已保存：$SAVE_PATH\nTip：编辑后的文件由用户指定"
        ;;
    *)
        notify-send "参数错误" "支持：--full（全屏）、--area（区域）、--edit（编辑）"
        ;;
esac