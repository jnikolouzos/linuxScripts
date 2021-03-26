#!/bin/bash
#reads the battery percentage
PRC=$(upower -d | grep -m 1 percentage: | cut -c 25-27 | xargs)

#if it's less than 10 it has also % sign
if [[ $PRC == *"%"* ]]; then
    PRC=$(echo $PRC | cut -c 1-1)
fi

#reads the if the battery is charging
STATE=$(upower -d | grep -m 1 state: | cut -c 25-37 | xargs)

#the file that keeps the levels notified. this is needed to avoid spamming on low battery every minute (25%, etc). this will notify once per value until reboot or charged
FILE="/tmp/battery.properties"

#reset the values and create the properties file
reset() {
    NOTIFIED25=false
    NOTIFIED20=false
    NOTIFIED15=false
    NOTIFIED10=false
    NOTIFIED8=false
    NOTIFIED6=false
    updatePropertiesFile
}

#updates the values on properties file
updatePropertiesFile() {
    echo "NOTIFIED25=$NOTIFIED25" > $FILE
    echo "NOTIFIED20=$NOTIFIED20" >> $FILE
    echo "NOTIFIED15=$NOTIFIED15" >> $FILE
    echo "NOTIFIED10=$NOTIFIED10" >> $FILE
    echo "NOTIFIED8=$NOTIFIED8" >> $FILE
    echo "NOTIFIED6=$NOTIFIED6" >> $FILE
}

#a notification for low battery
notifyLow() {
    /usr/bin/notify-send --urgency=NORMAL --icon=battery-low 'Battery level low' "The battery is on ${PRC}%."
    updatePropertiesFile
}

#a notification for very low battery
notifyHigh() {
    /usr/bin/notify-send --urgency=CRITICAL --icon=battery-caution 'Battery level very low' "The battery is on ${PRC}%. Plug the charger!"
    updatePropertiesFile
}


#a notification for critically low battery
notifyCritical() {
    /usr/bin/notify-send --urgency=CRITICAL --icon=battery-empty 'Battery level CRITICAL' "The battery is on ${PRC}%. Plug the charger!"
    /usr/bin/spd-say 'battery low'
}

#if property file exists, read the values
if [ -f "$FILE" ]
then
  while IFS='=' read -r key value
  do
    key=$(echo $key | tr '.' '_')
    eval ${key}=\${value}
  done < "$FILE"
else
    reset
fi

#if the battery is charging, we reset the notification flags. if not, we check the percentage and notify the user.
if [ "$STATE" = "discharging" ]
then
    if [ "$PRC" = "25" ] && [ "$NOTIFIED25" = "false" ] 
    then
        NOTIFIED25=true
        notifyLow
    elif [ "$PRC" = "20" ] && [ "$NOTIFIED20" = "false" ] 
    then
        NOTIFIED20=true
        notifyLow
    elif [ "$PRC" = "14" ] && [ "$NOTIFIED15" = "false" ] 
    then
        echo "15"
        NOTIFIED15=true
        notifyLow
    elif [ "$PRC" = "10" ] && [ "$NOTIFIED10" = "false" ] 
    then
        NOTIFIED10=true
        notifyHigh
    elif [ "$PRC" = "8" ] && [ "$NOTIFIED8" = "false" ] 
    then
        NOTIFIED10=true
        notifyHigh
    elif [ "$PRC" = "6" ] && [ "$NOTIFIED6" = "false" ] 
    then
        NOTIFIED10=true
        notifyHigh
    elif [ "$PRC" -lt "6" ]
    then
        notifyCritical
    fi
else#!/bin/bash
2
#reads the battery percentage
3
PRC=$(upower -d | grep -m 1 percentage: | cut -c 25-27 | xargs)
4
​
5
#if it's less than 10 it has also % sign
6
if [[ $PRC == *"%"* ]]; then
7
    PRC=$(echo $PRC | cut -c 1-1)
8
fi
9
​
10
#reads the if the battery is charging
11
STATE=$(upower -d | grep -m 1 state: | cut -c 25-37 | xargs)
12
​
13
#the file that keeps the levels notified. this is needed to avoid spamming on low battery every minute (25%, etc). this will notify once per value until reboot or charged
14
FILE="/tmp/battery.properties"
15
​
16
#reset the values and create the properties file
17
reset() {
18
    NOTIFIED25=false
19
    NOTIFIED20=false
20
    NOTIFIED15=false
21
    NOTIFIED10=false
22
    NOTIFIED8=false
23
    NOTIFIED6=false
24
    updatePropertiesFile
25
}
26
​
27
#updates the values on properties file
28
updatePropertiesFile() {
29
    echo "NOTIFIED25={$NOTIFIED25}" > $FILE
30
    echo "NOTIFIED20={$NOTIFIED20}" >> $FILE
31
    echo "NOTIFIED15={$NOTIFIED15}" >> $FILE
32
    echo "NOTIFIED10={$NOTIFIED10}" >> $FILE
33
    echo "NOTIFIED8={$NOTIFIED8}" >> $FILE
34
    echo "NOTIFIED6={$NOTIFIED6}" >> $FILE
35
}
36
​
37
#a notification for low battery
38
notifyLow() {
39
    /usr/bin/notify-send --urgency=NORMAL --icon=battery-low 'Battery level low' "The battery is on ${PRC}%."
40
    updatePropertiesFile
41
}
42
​
43
#a notification for very low battery
44
notifyHigh() {
45
    /usr/bin/notify-send --urgency=CRITICAL --icon=battery-caution 'Battery level very low' "The battery is on ${PRC}%. Plug the charger!"
    reset
fi
