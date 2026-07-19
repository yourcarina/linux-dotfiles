#!/usr/bin/env bash
# hyprland 下锁屏与桌面壁纸随机切换脚本
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

DESKTOP_WALLPAPER_PATH="$WALLPAPER_DIR/wallpaper-desktop"

LOCKSCREEN_WALLPAPER_PATH="$WALLPAPER_DIR/wallpaper-lockscreen"

SUPPORTED_FORMATS=("png" "jpg" "jpeg" "webp" "jxl")

# 收集壁纸
wallpapers=()
for ext in "${SUPPORTED_FORMATS[@]}"; do
  while IFS= read -r file; do
    wallpapers+=("$file")
  done < <(find "$WALLPAPER_DIR" -type f -iname "*.$ext")
done

if [ ${#wallpapers[@]} -eq 0 ]; then
  echo "未找到支持的壁纸文件"
  exit 1
fi

# 随机一张
random_wallpaper=${wallpapers[$RANDOM % ${#wallpapers[@]}]}

# 更新软链接
ln -sf "$random_wallpaper" "$DESKTOP_WALLPAPER_PATH"
ln -sf "$random_wallpaper" "$LOCKSCREEN_WALLPAPER_PATH"

# 关键：强制卸载 + 预加载 + 设置
hyprctl hyprpaper unload all >/dev/null 2>&1
# hyprctl hyprpaper preload "$DESKTOP_WALLPAPER_PATH" 实测提示无效的命令
hyprctl hyprpaper wallpaper ",$DESKTOP_WALLPAPER_PATH"

echo "已切换: $random_wallpaper"