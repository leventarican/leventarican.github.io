+++
title = "Linux"
date = 2021-03-18
+++

# Free up space
Use __autoremove__ on ubuntu to remove old packages, kernel, ...
```
sudo apt-get autoremove
```
You can also clean __apt chache__
```
sudo du -sh /var/cache/apt
sudo apt-get autoclean
```
Clear __systemd journal logs__ older then 3 days
```
journalctl --disk-usage
sudo journalctl --vacuum-time=3d
```
Remove __snap__ older versions
```
du -h /var/lib/snapd/snaps

#!/bin/bash
# Removes old revisions of snaps
# CLOSE ALL SNAPS BEFORE RUNNING THIS
set -eu
snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        snap remove "$snapname" --revision="$revision"
    done
```
If you want to use a UI then stacer is a good tool

# Snap
The `snap-store` under linux using ~ 500MB. As an alternative you can use `gnome-software`.
```
sudo snap remove snap-store && sudo apt install gnome-software
```

# Links
* https://itsfoss.com/free-up-space-ubuntu-linux/
* https://github.com/oguzhaninan/Stacer
