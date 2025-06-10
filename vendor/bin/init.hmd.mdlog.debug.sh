#!/vendor/bin/sh

umask 022
export PS4='+{$LINENO:${FUNCNAME[0]}} '
set -x

Log(){
    log -p d -t hmdmodemlog $1
}

Log "tomcat debug Start capture the modem log on user version,import parameters"

etr_size="0x2000000"
srcenable="enable_source"
sinkenable="enable_sink"

mkdir /config/stp-policy/coresight-stm:p_ost.policy
chmod 660 /config/stp-policy/coresight-stm:p_ost.policy
mkdir /config/stp-policy/coresight-stm:p_ost.policy/default
chmod 660 /config/stp-policy/coresight-stm:p_ost.policy/default
echo 0x10 > /sys/bus/coresight/devices/coresight-stm/traceid

#application by "oem_2902" group
chown -h root.oem_2902 /sys/devices/platform/soc/10048000.tmc/coresight-tmc-etr/block_size
chmod 660 /sys/devices/platform/soc/10048000.tmc/coresight-tmc-etr/block_size
chown -h root.oem_2902 /sys/devices/platform/soc/10048000.tmc/coresight-tmc-etr/buffer_size
chmod 660 /sys/devices/platform/soc/10048000.tmc/coresight-tmc-etr/buffer_size
chmod 660 /sys/devices/platform/soc/10048000.tmc/coresight-tmc-etr/out_mode
chown -h root.oem_2902 /sys/devices/platform/soc/1004f000.tmc/coresight-tmc-etr1/block_size
chmod 660 /sys/devices/platform/soc/1004f000.tmc/coresight-tmc-etr1/block_size
chown -h root.oem_2902 /sys/devices/platform/soc/1004f000.tmc/coresight-tmc-etr1/buffer_size
chmod 660 /sys/devices/platform/soc/1004f000.tmc/coresight-tmc-etr1/buffer_size
chmod 660 /sys/devices/platform/soc/1004f000.tmc/coresight-tmc-etr1/out_mode
chmod 660 /sys/devices/platform/soc/1004f000.tmc/coresight-tmc-etr1/enable_sink
chmod 660 /sys/devices/platform/soc/soc:modem_diag/coresight-modem-diag/enable_source
chown -h root.oem_2902 /sys/bus/coresight/reset_source_sink
chmod 660 /sys/bus/coresight/reset_source_sink

echo $etr_size > /sys/bus/coresight/devices/coresight-tmc-etr/buffer_size
echo 1 > /sys/bus/coresight/devices/coresight-tmc-etr/$sinkenable
echo coresight-stm > /sys/class/stm_source/ftrace/stm_source_link
echo 1 > /sys/bus/coresight/devices/coresight-stm/$srcenable
echo 0 > /sys/bus/coresight/devices/coresight-stm/hwevent_enable


Log "finish importing parameters"
export PS4='+{$LINENO:${FUNCNAME[0]}} '
set +x

