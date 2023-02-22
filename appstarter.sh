#! /bin/bash
# 命令调用脚本

source ~/.profile

case $1 in
    terminal) st ;;
    scratchpad) st -t scratchpad -c float ;;
    filemanager) thunar ;;
    browser) google-chrome-stable ;;
    # music) st ;;
    # video) st ;;
    # wechat) st ;;
    ssr) /opt/clash-for-windows-chinese/cfw ;;
    rofi_run) rofi -show run -theme $DWM_PATH/rofi/rofi_r.rasi ;;
    rofi_drun) rofi -show drun -theme $DWM_PATH/rofi/rofi_d.rasi ;;
    rofi_window) rofi -show window -theme $DWM_PATH/rofi/rofi_w.rasi ;;
    rofi_custom) rofi -show menu -modi "menu:$DWM_PATH/rofi/rofi_menu.sh" -theme $DWM_PATH/rofi/rofi_r.rasi ;;
    screenkey) $DWM_PATH/screenkey.sh ;;
    blurlock) $DWM_PATH/blurlock.sh ;;
    set_screen) $DWM_PATH/set_screen.sh sel ;;
    screenshot) xfce4-screenshooter -c -s ~/Pictures/screenshots ;;
esac
