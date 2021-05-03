# linuxScripts

**battery**

This script adds notifications for laptop battery level.
To use it, add the following to cron: * * * * *       XDG_RUNTIME_DIR=/run/user/$(id -u) /bin/sh /the-path-to-your-script/battery.sh

If you don't know how to do it, follow these steps:
1. download battery.sh
2. place it someware on your file system (for example /home/jim/Desktop/)
3. open a shell 
4. type: sudo chmod +x /the-path-to-your-script/battery.sh (in my case: sudo chmod +x /home/jim/Desktop/battery.sh)
5. on shell type: croptab -e
6. go to bottom on a new line
7. paste this: * * * * *       env DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus /the-path-to-your-script/battery.sh >/the-path-to-your-script/battery.log 2>&1
8. rename the-path-to-your-script with the path that you've stored the battery.sh
9. ctrl + X
10. y
11. enter

If everything done properly, when the laptop is in discharging state, when the battery is low, you'll get notifications.

