-- 更多信息参阅 https://wiki.hypr.land/Configuring/Start/
-- 可分离配置并使用以下语句引入：
-- require("myColors")

------------------
---- 显示器 ----
------------------

-- 参见 https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
  output   = "",
  mode     = "preferred",
  position = "auto",
  scale    = "auto",
})

---------------------
---- 我的程序 ----
---------------------

-- 设置你使用的程序
local terminal    = "kitty"
local fileManager = "kitty -e yazi"
local menu        = "wofi --show drun"

-------------------
---- 自动启动 ----
-------------------

-- 参见 https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
  hl.exec_cmd(terminal)
  hl.exec_cmd("sleep 8 && waybar")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("fcitx5 --replace -d")
  hl.exec_cmd("hyprlock")
  hl.exec_cmd("hyprsunset")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("mako")
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
  -- 启用 cliphist 剪切板管理
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")
  -- 启用 kdeconnect 服务与托盘
  hl.exec_cmd("/usr/lib/kdeconnectd&!")
  hl.exec_cmd("/usr/bin/kdeconnect-indicator&!")
  -- 开机自动随机切换壁纸
  hl.exec_cmd("sleep 8 && sys-wallpaper")
end)

-------------------------------
---- 环境变量 ----
-------------------------------

-- 参见 https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- 输入法环境变量
hl.env("QT_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("SDL_IM_MODULE", "fcitx")
hl.env("GLFW_IM_MODULE", "ibus")
hl.env("QT_IM_MODULES", "wayland;fcitx;ibus")
-- 由于 hyprland 原生支持 wayland 所以已经不需要此变量
-- hl.env("GTK_IM_MODULE", "fcitx")

-----------------------
----- 权限 -----
-----------------------

-- 参见 https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- 请注意，此处的权限更改需要重启 Hyprland，并且不会即时生效
-- 出于安全原因

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-----------------------
---- 外观与体验 ----
-----------------------

-- 参考 https://wiki.hypr.land/Configuring/Basics/Variables/

hl.config({
  general = {
    -- 窗口间间隙
    gaps_in = 8,
    -- 窗口与屏幕间间隙
    gaps_out = 8,
    -- 边框大小
    border_size = 0,

    col = {
      -- 活动窗口边框颜色
      active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
      -- 非活动窗口边框颜色
      inactive_border = "rgba(595959aa)",
    },

    -- 设置为 true 以允许通过点击并拖动边框和间隙来调整窗口大小
    resize_on_border = true,

    -- 在启用此功能之前，请参阅 https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/
    allow_tearing = false,

    -- 布局方式 master dwindle scrolling
    layout = "scrolling",
  },

  -- https://wiki.hypr.land/Configuring/Variables/#decoration
  decoration = {
    -- 圆角半径
    rounding = 2,
    -- 圆角强度
    rounding_power = 24,

    -- 更改聚焦和未聚焦窗口的透明度
    active_opacity = 1.0,
    inactive_opacity = 0.6,

    shadow = {
      -- 启用阴影
      enabled = true,
      -- 阴影范围
      range = 2,
      -- 阴影渲染强度
      render_power = 4,
      -- 阴影颜色
      color = 0xee1a1a1a,
    },

    -- https://wiki.hypr.land/Configuring/Variables/#blur
    blur = {
      -- 启用模糊
      enabled = true,
      -- 模糊大小
      size = 3,
      -- 模糊遍数
      passes = 1,
      -- 色彩鲜艳度
      vibrancy = 0.1696,
    },
  },

  -- https://wiki.hypr.land/Configuring/Variables/#animations
  animations = {
    -- 启用动画
    enabled = true,
  },
})

-- 默认曲线和动画，参见 https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- 默认弹簧
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- 参考 https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- “智能间距” / “仅当单窗口时无间距”
-- 如果你想使用此功能，请取消注释所有相关行。
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--   name = "no-gaps-wtv1",
--   match = { float = false, workspace = "w[tv1]" },
--   border_size = 0,
--   rounding = 0,
-- })
-- hl.window_rule({
--   name = "no-gaps-f1",
--   match = { float = false, workspace = "f[1]" },
--   border_size = 0,
--   rounding = 0,
-- })

-- 有关更多信息，请参见 https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
hl.config({
  dwindle = {
    -- 你可能想要这个
    preserve_split = true,
  },
})

-- 有关更多信息，请参见 https://wiki.hypr.land/Configuring/Layouts/Master-Layout/
hl.config({
  master = {
    new_status = "master",
  },
})

-- 有关更多信息，请参见 https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/
hl.config({
  scrolling = {
    -- 新建的窗口的默认宽/高度
    column_width = 1.0,
    -- 仅一个窗口时自动最大宽度
    fullscreen_on_one_column = true,
    -- 切换窗口聚焦时自动移动窗口位置
    follow_focus = true,
    -- 聚焦时窗口显示规则：0 center 1 fit
    focus_fit_method = 0,
    -- 聚焦时窗口在屏幕内的最小可见比例
    follow_min_visible = 0.8,
    -- 循环切换列宽/高时的预设值
    explicit_column_widths = "0.5, 0.6, 0.7, 0.8, 0.9, 1.0",
    -- 滚动方向 left right up down
    direction = "down",
    wrap_focus = true,
    wrap_swapcol = true,
  },
})

----------------
---- 杂项 ----
----------------

hl.config({
  misc = {
    -- 设置为 0 或 1 以禁用动漫吉祥物壁纸
    force_default_wallpaper = 0,
    -- 如果为 true，则禁用随机的 hyprland 徽标/动漫女孩背景
    disable_hyprland_logo = true,
    -- 若 dpms 关闭则在按下按键时唤醒屏幕
    key_press_enables_dpms = true,
  },
})

---------------
---- 输入 ----
---------------

hl.config({
  input = {
    -- 键盘布局
    kb_layout = "us",
    -- 键盘变体
    kb_variant = "",
    -- 键盘型号
    kb_model = "",
    -- 键盘选项
    kb_options = "",
    -- 键盘规则
    kb_rules = "",

    -- 跟随鼠标
    follow_mouse = 1,

    -- 灵敏度 -1.0 - 1.0，0 表示不修改。
    sensitivity = 0,

    touchpad = {
      -- 触摸板自然滚动
      natural_scroll = false,
    },
  },
})

-- 每个设备的配置示例
-- 有关更多信息，请参见 https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/
hl.device({
  name = "epic-mouse-v1",
  -- 鼠标灵敏度
  sensitivity = -0.5,
})

---------------------
---- 键绑定 ----
---------------------

-- 绑定示例，请参见 https://wiki.hypr.land/Configuring/Basics/Binds/ 获取更多信息

-- 将“Windows”键设置为主修饰键
local mainMod = "SUPER"

-- 打开终端
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))

-- 关闭活动窗口
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)

-- 退出 hyprland
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

-- 打开文件管理器
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))

-- 切换浮动状态
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))

-- 打开菜单
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))

-- 伪平铺开关
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- 仅适用于 dwindle 布局
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

-- 使用 mainMod + 方向键移动焦点
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- 使用 mainMod + [0-9] 切换工作区
-- 使用 mainMod + SHIFT + [0-9] 将活动窗口移动到某个工作区
for i = 1, 10 do
  local key = i % 10 -- 10 映射到键 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- 特殊工作区示例（暂存区）
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- 使用 mainMod + 滚轮在现有工作区之间滚动
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- 使用 mainMod + 左键/右键并拖动来移动/调整窗口大小
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- 笔记本多媒体键，用于音量和 LCD 亮度
-- hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
-- hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
-- hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
-- hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
-- hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
-- hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("hypr-volume --inc"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("hypr-volume --dec"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("hypr-volume --toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("hypr-volume --toggle-mic"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("hypr-backlight --inc"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("hypr-backlight --dec"), { locked = true, repeating = true })

-- 键盘背光控制
-- hl.bind("keyboard_brightness_up_shortcut", hl.dsp.exec_cmd("hypr-kbbacklight --inc"), { locked = true, repeating = true })
-- hl.bind("keyboard_brightness_down_shortcut", hl.dsp.exec_cmd("hypr-kbbacklight --dec"), { locked = true, repeating = true })

-- 多媒体控制；需要 playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- 召唤剪切板
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("cliphist list | wofi -S dmenu --width 1280 --height 1280 --lines 8 | cliphist decode | wl-copy"))

-- 随机壁纸
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("sys-wallpaper"))

-- 截屏配置
-- hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("grim \"$(slurp)\" ~/Picture/Screenshots/Screenshot_$(date +'%Y%m%d_%H%M%S').png"))
-- hl.bind(mainMod .. " + ALT + Print", hl.dsp.exec_cmd("grim -g \"$(slurp)\" ~/Picture/Screenshots/Screenshot_$(date +'%Y%m%d_%H%M%S').png"))
-- hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | swappy -f -"))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("waybar-screenshot --full"))
hl.bind(mainMod .. " + ALT + Print", hl.dsp.exec_cmd("waybar-screenshot --area"))
hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd("waybar-screenshot --edit"))

-- 全屏窗口
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

-- 锁屏
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

-- 电源菜单
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("wlogout"))

-- 获取系统信息
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal .. " --hold hyfetch"))

-- 合盖/开盖逻辑
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("hyprctl dispatch dpms off && sleep 1 & hyprlock"), { locked = true })
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("hyprctl dispatch dpms on"), { locked = true })

-- Scrolling 布局相关
-- 此处停用；同类实现参看上方手势设置。
-- 备选参数： -conf 调整聚焦窗口的大小
-- hl.bind(mainMod .. " + SPACE", hl.dsp.layout("colresize +conf"))
-- 备选参数： r l 将聚焦窗口与其右侧/下方窗口交换
-- hl.bind(mainMod .. " + ALT + SPACE", hl.dsp.layout("swapcol r"))

-- Master 布局相关
hl.bind(mainMod.. " + SPACE", hl.dsp.layout("swapwithmaster auto"))

--------------------------------
----- 手势操作 ----
--------------------------------

hl.gesture({ fingers = 3, direction = "horizontal",  action = "workspace" })
hl.gesture({ fingers = 3, direction = "vertical", action = "scroll_move" })

-- 双指缩放窗口
-- 仅适配 Scrolling 布局
-- 双指捏合缩小窗口
hl.gesture({
  fingers = 2,
  direction = "pinchin",
  scale = 8.0,
  action = function()
    hl.dispatch(hl.dsp.layout("colresize -conf"))
  end
})
-- 双指展开扩展窗口
hl.gesture({
  fingers = 2,
  direction = "pinchout",
  scale = 8.0,
  action = function()
    hl.dispatch(hl.dsp.layout("colresize +conf"))
  end
})

-- 双指 + SUPER 交换活动窗口
-- 仅适配 Scrolling 布局
-- 双指捏合与上方/左侧窗口交换
hl.gesture({
  fingers = 2,
  direction = "pinchin",
  mods = mainMod,
  scale = 8.0,
  action = function()
    hl.dispatch(hl.dsp.layout("swapcol l"))
  end
})
-- 双指展开与下方/右侧窗口交换
hl.gesture({
  fingers = 2,
  direction = "pinchout",
  mods = mainMod,
  scale = 8.0,
  action = function()
    hl.dispatch(hl.dsp.layout("swapcol r"))
  end
})

--------------------------------
---- 窗口和工作区 ----
--------------------------------

-- 参见 https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- 以及 https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- 有用的窗口规则示例

local suppressMaximizeRule = hl.window_rule({
  -- 忽略来自所有应用的最大化请求
  name = "suppress-maximize-events",
  match = { class = ".*" },

  suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
  -- 修复 XWayland 的一些拖动问题
  name = "fix-xwayland-drags",
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },

  no_focus = true,
})

-- 图层规则也返回一个句柄
-- local overlayLayerRule = hl.layer_rule({
--   name = "no-anim-overlay",
--   match = { namespace = "^my-overlay$" },
--   no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run 窗口规则
hl.window_rule({
  name = "move-hyprland-run",
  match = { class = "hyprland-run" },

  move = "20 monitor_h-120",
  float = true,
})

-- 为工作区单独设置布局
hl.workspace_rule({
  workspace = "special:magic",
  layout = "master",
})
