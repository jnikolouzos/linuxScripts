# linuxScripts

**battery**
This script adds notifications for laptop battery level.
To use it, add the following to cron.
* * * * *       XDG_RUNTIME_DIR=/run/user/$(id -u) /bin/sh /the-path-to-your-script/battery.sh

If you don't know how to do it, follow these steps:
1. on shell type: croptab -e
2. go to bottom on a new line
3. paste this: * * * * *       XDG_RUNTIME_DIR=/run/user/$(id -u) /bin/sh /the-path-to-your-script/battery.sh
4. rename the-path-to-your-script with the path that you've stored the battery.sh
5. ctrl + X
6. y
7. enter

If everything done properly, when the laptop is in discharging state, when the battery is low, you'll get notifications.

