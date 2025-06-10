#! /vendor/bin/sh
#chown -hR root.media_rw /sdcard/Notifications/data/vendor/modem_config/mcfg_sw/*

#cp /vendor/etc/sensors/scripts/* /data/vendor/sensors/scripts/
#chmod 777 /data/otaclient/mcfg_sw/ -R
#cp --preserve=m -dr /data/otaclient/mcfg_sw/* /data/vendor/modem_config/mcfg_sw
#rm -rf /sdcard/Notifications/data/vendor/modem_config/mcfg_sw/*

BIN_PATH="/vendor/bin/hw/eos_update_product"
ARG1="-u"
ARG2="--update"

$BIN_PATH $ARG1 



