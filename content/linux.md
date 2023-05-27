+++
title = "Linux"
date = 2021-03-18
+++



# Curl
```bash
sudo curl -L https://down.load/file -o here
```

# Memory usage
NOTE, that _cache_ does not take memory from apps. 
```bash
free -wh
```

# Compressed Files
Unpack compressed tar gz files
```bash
tar xfv ../Downloads/zulu8.40.0.25-ca-jdk8.0.222-linux_x64.tar.gz
unzip netbeans.zip
unzip -l netbeans.zip	// list files
unzip netbeans.zip -d specific-dir/		// extract to dir specific dir
zip -r -0 -s 900m archive-0.zip folder-to-archive/    // split zip each 900MB; just archive no compress; recursivly.
```

# Copy Files
Copy all files with `file-*` to current folder. verbose on.
```bash
cp -v folder/file-* .
```

Copy files multible times
```bash
for i in {1..100}; do cp free.ogg "free$i.ogg"; done
```

# Disc usage
Display free disk space; human readable; max depth
```bash
df -h .
du -h --max-depth=1 /home/
```


# Network
```bash
arp	// list MAC adress to IP adress
cat /var/dhcp.leases	// show IP adress, hostname, MAC adress
nmap -v ip.adress	// fast simple scan for default ports
sudo service dnsmasq restart	// restart dnsmasq: DCHP server (usually this is installed on openwrt)
dmesg	// display kernel ring buffer (data structure of messages operated by kernel)
```

# Symbolic links
Create and remove symbolic links.
```bash
ln -s zulu8.40.0.25-ca-jdk8.0.222-linux_x64 jdk
rm jdk  // remove symbolic link
```

# Image resize
You need a `imagemagick` tool for this command.
```bash
convert -resize 25% screenshot.png screenshot.png
```

# Find
Find files named `*.md` in or below the directory `development/` with max depth 2
```bash
find development/ -maxdepth 2 -name *README.md -type f -print
```

# System specification
The command `lshw` should be installed by default.
With `lshw` you can list cpu, memory or all system information in console, as json or html.

List memory only.
```bash
sudo lshw -C memory
  *-memory                  
       description: System Memory
       physical id: 1
       slot: System board or motherboard
       size: 16GiB
```

List systen information: machine, cpu, battery, ...
```bash
inxi
inxi -Fxz

# Battery:   ID-1: BAT0 charge: 42.4 Wh condition: 53.3/57.0 Wh (93%) status: Not charging
```

List all with format html.
```bash
sudo lshw -html > specs.html
```

# Free up space
Use __autoremove__ on ubuntu to remove old packages, kernel, ...
```bash
sudo apt-get autoremove
```
You can also clean __apt chache__
```bash
sudo du -sh /var/cache/apt
sudo apt-get autoclean
```
Clear __systemd journal logs__ older then 3 days
```bash
journalctl --disk-usage
sudo journalctl --vacuum-time=3d
```
Remove __snap__ older versions
```bash
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
If you want to use a UI then _stacer_ is a good tool

# Snap
The `snap-store` under linux using ~ 500MB. As an alternative you can use `gnome-software`.
```bash
sudo snap remove snap-store && sudo apt install gnome-software
```

# Battery
Calculate the battery capacity with energy_full values: `56760000 / 57020000 * 100 = 99.5%`
```bash
cat /sys/class/power_supply/BAT0/energy_full
56760000

cat /sys/class/power_supply/BAT0/energy_full_design
57020000
```

Tools like `tlp` or `tlp-stat --battery` could also be useful for battery management or stats.

# Links
* https://itsfoss.com/free-up-space-ubuntu-linux/
* https://github.com/oguzhaninan/Stacer
