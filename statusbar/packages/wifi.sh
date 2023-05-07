#! /bin/bash

source ~/.profile

this=_wifi
icon_color="^c#000080^^b#3870560x88^"
text_color="^c#000080^^b#3870560x99^"
signal=$(echo "^s$this^" | sed 's/_//')

update() {
    wifi_icon="󰌹"
    wifi_text=$(nmcli | grep 已连接 | awk '{print $3}')
    [ "$wifi_text" = "" ] && wifi_text="未连接"

    wifi_list=($wifi_text)

    icon=" $wifi_icon "
    text=$(IFS=,; echo " ${wifi_list[*]} ")

    sed -i '/^export '$this'=.*$/d' $DWM_STATUS_TMPFILE
    printf "export %s='%s%s%s%s%s'\n" $this "$signal" "$icon_color" "$icon" "$text_color" "$text" >> $DWM_STATUS_TMPFILE
}

notify() {
    update
    connect=$(nmcli | grep 已连接 | awk '{print $3}')
    device=$(nmcli | grep 已连接 | awk '{print $1}'  | sed 's/：已连接//')

    connect_list=($connect)
    device_list=($device)
    device_cnt=${#device_list[@]}

    text=""
    for ((i=0; i<${device_cnt}; i++)); do
	    text="$text设备: $device\n连接: $connect\n\n"
    done
    [ "$text" != "" ] && text=${text::-2}

    [ "$connect" = "" ] && text="未连接到网络"
    notify-send -r 9527 "$wifi_icon Wifi" "\n$wifi_text"
}

call_nm() {
    pid1=`ps aux | grep 'st -t statusutil' | grep -v grep | awk '{print $2}'`
    pid2=`ps aux | grep 'st -t statusutil_nm' | grep -v grep | awk '{print $2}'`
    mx=`xdotool getmouselocation --shell | grep X= | sed 's/X=//'`
    my=`xdotool getmouselocation --shell | grep Y= | sed 's/Y=//'`
    kill $pid1 && kill $pid2 2>/dev/null
    st -t statusutil_nm -g 60x25+$((mx - 240))+$((my + 20)) -c FGN -e 'nmtui-connect'
}

click() {
    case "$1" in
        L) notify ;;
        R) call_nm ;;
    esac
}

case "$1" in
    click) click $2 ;;
    notify) notify ;;
    *) update ;;
esac
