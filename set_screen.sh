#! /bin/bash
:<<!
  设置屏幕分辨率的脚本(xrandr命令的封装)
  one: 只展示一个内置屏幕 2560x1600 缩放为 1440x900
  two: 左边展示外接屏幕 - 右边展示内置屏幕 都用匹配1080p屏幕DPI的缩放比
  check: 检测显示器连接状态是否变化 变化则自动调整输出情况
!

# 定义内置屏幕接口和外接屏幕接口
INNER_PORT=$(xrandr | grep -w 'connected' | grep 'eDP'| awk '{print $1}')
OUTPORT1=DP-1-1
OUTPORT2=DP-1-2

# 查找已连接、未连接的外接接口
OUTPORT_CONNECTED=$(xrandr | grep -v $INNER_PORT | grep -w 'connected' | awk '{print $1}')
OUTPORT_DISCONNECTED=$(xrandr | grep -v $INNER_PORT | grep -w 'disconnected' | awk '{print $1}')

one() {
    xrandr --output $INNER_PORT --mode 2560x1440 --pos 0x0 --scale 1x1 --primary \
           --output $OUTPORT1 --off \
           --output $OUTPORT2 --off
    feh --randomize --bg-fill ~/Pictures/wallpaper/*.png
}

only_inner_port() {
    xrandr --output $INNER_PORT --mode 2560x1440 --pos 0x0 --scale 1x1 --primary \
           --output $OUTPORT1 --off \
           --output $OUTPORT2 --off
    [ ! "$OUTPORT_CONNECTED" ] && return # 如果没有外接屏幕则直接调用one函数
    xrandr --output $OUTPORT_CONNECTED --off
    feh --randomize --bg-fill ~/Pictures/wallpaper/*.png
}

only_out_port() {
    [ ! "$OUTPORT_CONNECTED" ] && one && return # 如果没有外接屏幕则直接调用one函数
    xrandr --output $INNER_PORT --off \
           --output $OUTPORT1 --off \
           --output $OUTPORT2 --off \
           --output $OUTPORT_CONNECTED --mode 1920x1080 --pos 0x0 --scale 1x1 --primary
    feh --randomize --bg-fill ~/Pictures/wallpaper/*.png
}

copy() {
    [ ! "$OUTPORT_CONNECTED" ] && one && return # 如果没有外接屏幕则直接调用one函数
    xrandr --output $INNER_PORT --mode 1920x1080 --pos 0x0 --scale 1x1 --primary \
           --output $OUTPORT_CONNECTED --mode 1920x1080 --pos 0x0 --scale 1x1
    feh --randomize --bg-fill ~/Pictures/wallpaper/*.png
}

left_extend() {
    [ ! "$OUTPORT_CONNECTED" ] && one && return # 如果没有外接屏幕则直接调用one函数
    xrandr --output $INNER_PORT --mode 2560x1440 --pos 1920x0 --scale 1x1 --primary \
           --output $OUTPORT_CONNECTED --mode 1920x1080 --pos 0x0 --scale 1x1
    feh --randomize --bg-fill ~/Pictures/wallpaper/*.png
}

right_extend() {
    [ ! "$OUTPORT_CONNECTED" ] && one && return # 如果没有外接屏幕则直接调用one函数
    xrandr --output $INNER_PORT --mode 2560x1440 --pos 0x0 --scale 1x1 --primary \
           --output $OUTPORT_CONNECTED --mode 1920x1080 --pos 2560x0 --scale 1x1
    feh --randomize --bg-fill ~/Pictures/wallpaper/*.png
}

call_menu() {
    case $(echo -e '1.仅电脑屏幕\n2.复制\n3.左侧扩展\n4.右侧扩展\n5.仅第二屏幕' | rofi -dmenu -window-title 屏幕设置 -theme $DWM_PATH/rofi/rofi_ps.rasi) in
        "1.仅电脑屏幕") only_inner_port ;;
        "2.复制") copy ;;
        "3.左侧扩展") left_extend ;;
        "4.右侧扩展") right_extend ;;
        "5.仅第二屏幕") only_out_port ;;
    esac
}

case $1 in
    one) one ;;
    left_extend) left_extend ;;
    sel) call_menu ;;
    *) one ;;
esac
