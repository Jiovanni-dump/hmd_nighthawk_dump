#!/vendor/bin/sh

umask 022
export PS4='+{$LINENO:${FUNCNAME[0]}} '
set -x

Log(){
    log -p d -t hmdmodemlog $1
}

Log "Clean the log file"
#/vendor/bin/diag_mdlog -k -c
sleep 3s
Log "start hmd modem log"
cf=`getprop persist.vendor.debug.modemcfg | sed 's/\n//g'`

if [ -z "$cf" ]
then
cf="diag.cfg"
fi

Log "$cf"

mkdir -p /sdcard/hmdlogs/mdlog

fsync /sdcard/hmdlogs/

echo 1 > /sys/bus/coresight/reset_source_sink
echo 0 > /sys/kernel/debug/tracing/tracing_on
echo 0 > /sys/kernel/debug/tracing/events/enable

if [ x"$cf" = x"custom" ]; then
/system/vendor/bin/diag_mdlog -u -f /sdcard/diag.cfg -o /sdcard/hmdlogs/mdlog -q 2 -s 500 -n 10
else
#/system/vendor/bin/diag_mdlog_system -u -f /data/vendor/hmdlogs/mdlog/diag.cfg -o /data/vendor/hmdlogs/mdlog
#modify by jacky.wei@hmdglobal.com for required by  wenming.zheng@hmdglobal.com from email at 2021.01.05
/system/vendor/bin/diag_mdlog -u -f /vendor/etc/diag_config/"$cf" -o /sdcard/hmdlogs/mdlog -q 2 -s 500 -n 10
fi



Log "end hmd modem log, exit scripty"

export PS4='+{$LINENO:${FUNCNAME[0]}} '
set +x

