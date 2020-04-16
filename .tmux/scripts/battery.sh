#!/usr/bin/env bash
# Stolen from https://github.com/richoH/dotfiles/blob/master/bin/battery
# then edited to display percent if charging, and hearts if not
# NOTE: While I primarily use macOS, I've left in the Linux and FreeBSD
# implementations for compatability

linux_get_bat () {
    bf=$(cat $BAT_FULL)
    bn=$(cat $BAT_NOW)
    echo $(( 100 * $bn / $bf ))
}

freebsd_get_bat () {
    echo "$(sysctl -n hw.acpi.battery.life)"
}

battery_status() {
case $(uname -s) in
    "Linux")
        BATPATH=/sys/class/power_supply/BAT0
        STATUS=$BATPATH/status
        BAT_FULL=$BATPATH/energy_full
        BAT_NOW=$BATPATH/energy_now
        if [ "$1" = `cat $STATUS` -o "$1" = "" ]; then
            linux_get_bat
        fi
        ;;
    "FreeBSD")
        STATUS=`sysctl -n hw.acpi.battery.state`
        case $1 in
            "Discharging")
                if [ $STATUS -eq 1 ]; then
                    freebsd_get_bat
                fi
                ;;
            "Charging")
                if [ $STATUS -eq 2 ]; then
                    freebsd_get_bat
                fi
                ;;
            "")
                freebsd_get_bat
                ;;
        esac
        ;;
    "Darwin")
        ext=`ioreg -c AppleSmartBattery -w0 | awk '/IsCharging/ {print $5}'`
        ioreg -c AppleSmartBattery -w0 | \
        grep -o '"[^"]*" = [^ ]*' | \
        sed -e 's/= //g' -e 's/"//g' | \
        sort | \
        while read key value; do
            case $key in
                "MaxCapacity")
                    export maxcap=$value;;
                "CurrentCapacity")
                    export curcap=$value;;
                "ExternalConnected")
                    if [ "$ext" != "$value" ]; then
                        exit
                    fi
                ;;
                "FullyCharged")
                    if [ "$value" = "Yes" ]; then
                        exit
                    fi
                ;;
            esac
            if [[ -n "$maxcap" && -n $curcap ]]; then
                echo $(( 100 * $curcap / $maxcap ))
                break
            fi
        done
esac
}

BATTERY_STATUS=`battery_status $1`
[ -z "$BATTERY_STATUS" ] && exit
echo ${BATTERY_STATUS}%
