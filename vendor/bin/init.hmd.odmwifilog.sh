#!/vendor/bin/sh

umask 022
export PS4='+{$LINENO:${FUNCNAME[0]}} '
set -x

Log(){
    log -p d -t hmdmodemlog $1
}

Log "start copy wlan log"

mkdir -p /sdcard/hmdlogs/wlan_logs/
#cp -r /data/vendor/wifi/wlan_logs/ /sdcard/hmdlogs/

for i in `ls /data/vendor/wifi/wlan_logs/`
do
    Log $i
    cp /data/vendor/wifi/wlan_logs/$i /sdcard/hmdlogs/wlan_logs/
done

Log "end copy wlan log"

export PS4='+{$LINENO:${FUNCNAME[0]}} '
set +x

