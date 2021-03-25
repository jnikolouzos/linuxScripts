#!/bin/bash
PRC=$(upower -d | grep -m 1 percentage: | cut -c 25-27 | xargs)
STATE=$(upower -d | grep -m 1 state: | cut -c 25-37 | xargs)
echo $STATE
if [ "$STATE" = "discharging" ]
then
    if [ "$PRC" = "25" ] || [ "$PRC" = "20" ] || [ "$PRC" = "15" ] || [ "$PRC" = "31" ] || [ "$PRC" = "30" ] 
    then
    /usr/bin/notify-send --urgency=NORMAL --icon=battery-low 'Battery level low' "The battery is on ${PRC}%."
    elif [ "$PRC" = "10" ] || [ "$PRC" = "8" ] || [ "$PRC" = "6" ]
    then
    /usr/bin/notify-send --urgency=CRITICAL --icon=battery-caution 'Battery level very low' "The battery is on ${PRC}%. Plug the charger!"
    elif [ "$PRC" -lt "5" ]
    then
    /usr/bin/notify-send --urgency=CRITICAL --icon=battery-empty 'Battery level CRITICAL' "The battery is on ${PRC}%. Plug the charger!"
    /usr/bin/spd-say 'battery low'
    fi
fi

