#!/system/bin/sh

tag="init.set_baseband.sh"
baseband=$(strings -n 60 /vendor/firmware_mnt/image/modem.b19 | grep QC_IMAGE_VERSION_STRING | cut -c 25-)

if [ ! -z "$baseband" ]; then
    setprop gsm.version.baseband $baseband
    log -t $tag -p i "Baseband set to $baseband"
else
    baseband=$(strings -n 30 /vendor/firmware_mnt/image/modem.b* | grep QC_IMAGE_VERSION_STRING | cut -c 25-)
    if [ ! -z "$baseband" ]; then
        setprop gsm.version.baseband $baseband
        log -t $tag -p i "Baseband set to $baseband"
    else
        log -t $tag -p e "Couldn't read baseband from modem firmware"
    fi
fi
