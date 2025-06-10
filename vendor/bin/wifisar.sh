#!/bin/sh

Log(){
    log -p d -t cnce_wifisar $1
}

SARINFO=$(getprop vendor.sar.wifi_backoff_info)
SARINDEX=${SARINFO:6}
WLAN_INTERFACE=${SARINFO:0:5}
SAR_VENDOR_CMD_XML="/vendor/etc/wifi/sar-vendor-cmd.xml"

cd /vendor/bin/
Log "wifisar test"

if [[ $SARINDEX = 2 ]]; then
    ./vendor_cmd_tool -f $SAR_VENDOR_CMD_XML -i wlan0 --START_CMD --SAR_SET --ENABLE 2 --NUM_SPECS 0 --END_CMD
elif [[ $SARINDEX = 3 ]]; then
    ./vendor_cmd_tool -f $SAR_VENDOR_CMD_XML -i wlan0 --START_CMD --SAR_SET --ENABLE 3 --NUM_SPECS 0 --END_CMD
elif [[ $SARINDEX = 4 ]]; then
    ./vendor_cmd_tool -f $SAR_VENDOR_CMD_XML -i $WLAN_INTERFACE --START_CMD --SAR_SET --ENABLE 4 --NUM_SPECS 0 --END_CMD
elif [[ $SARINDEX = 5 ]]; then
    ./vendor_cmd_tool -f $SAR_VENDOR_CMD_XML -i wlan0 --START_CMD --SAR_SET --ENABLE 5 --NUM_SPECS 0 --END_CMD
elif [[ $SARINDEX = 6 ]]; then
    ./vendor_cmd_tool -f $SAR_VENDOR_CMD_XML -i wlan0 --START_CMD --SAR_SET --ENABLE 6 --NUM_SPECS 0 --END_CMD
fi

#echo '********************************************'
#echo SARINDEX is $SARINDEX
#echo SARINFO is $SARINFO
#echo WLAN_INTERFACE is $WLAN_INTERFACE
#echo SARINDEX is $SARINDEX
