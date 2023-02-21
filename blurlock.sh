#! /bin/bash
# 依赖包： i3lock-color

i3lock \
    --blur 10 \
    --bar-indicator \
    --bar-pos y+h \
    --bar-direction 1 \
    --bar-max-height 5 \
    --bar-base-width 5 \
    --bar-color 00000022 \
    --keyhl-color ffffffcc \
    --bar-periodic-step 50 \
    --bar-step 20 \
    --redraw-thread \
    --clock \
    --force-clock \
    --ind-pos x+w/2:y+h/2+80 \
    --time-pos x+w/2:y+h/2-40 \
    --date-pos tx:ty+60 \
    --time-color ffffffff \
    --date-color ffffffff \
    --date-str="%Y年%m月%d日 %A" \
    --time-size=120 \
    --date-size=40 \
    --verif-align 0 \
    --wrong-align 0 \
    --date-align 0 \
    --time-align 0 \
    --ringver-color ffffff00 \
    --ringwrong-color ffffff88 \
    --status-pos x+5:y+h-16 \
    --verif-color ffffffff \
    --wrong-color ffffffff \
    --modif-pos -50:-50

xdotool mousemove_relative 1 1 # 该命令用于解决自动锁屏后未展示锁屏界面的问题(移动一下鼠标)
