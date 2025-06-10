#!/vendor/bin/sh

if [ -c /dev/sec-nfc ]; then
     setprop persist.vendor.nfc.chip.type sec
else
     setprop persist.vendor.nfc.chip.type nonfc
fi
