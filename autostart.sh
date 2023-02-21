#! /bin/bash

source ~/.profile

settings() {
    [ $1 ] && sleep $1
    xset -b                                         # 关闭蜂鸣器
    #syndaemon -i 1 -t -K -R -d                     # 设置使用键盘时触控板短暂失效
    $DWM_PATH/set_screen.sh left_extend             # 设置显示器
}

daemons() {
    [ $1 ] && sleep $1
    xfce4-power-manager &                      # 电源管理器
    xfce4-clipman &                            # 剪切板
    /usr/lib/xfce-polkit/xfce-polkit &         # sudo提权
    $DWM_PATH/statusbar/statusbar.sh cron &    # 开启状态栏定时更新
    xss-lock -- $DWM_PATH/blurlock.sh &        # 开启自动锁屏程序
    fcitx5 &                                   # 开启输入法
    lemonade server &                          # 开启lemonade 远程剪切板支持
    dunst -conf $DWM_PATH/dunst/dunst.conf &   # 开启通知server
    picom --config $DWM_PATH/picom/picom.conf >> /dev/null 2>&1 & # 开启picom
}

cron() {
    [ $1 ] && sleep $1
    let i=10
    while true; do
        [ $((i % 300)) -eq 0 ] && feh --randomize --bg-fill ~/Pictures/wallpaper/*.png  # 每300秒更新壁纸
        sleep 10; let i+=10
    done
}

settings 1 &                                  # 初始化设置项
daemons 3 &                                   # 后台程序项
cron 5 &                                      # 定时任务项
