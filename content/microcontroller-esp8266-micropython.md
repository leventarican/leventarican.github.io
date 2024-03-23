+++
title = "Microcontroller: ESP8266 MicroPython"
date = 2024-03-23
+++

# ESP8266 MicroPython

# About
Programm the ESP8266 using MicroPython. Using MicroPython you are able to run code directly on target machine without compile and upload.

# System
* Espressif ESP-8266 
* usb-b to usb-a cable
* computer with linux

# Install
Before install ensure that you have `esptool.py`.

The easiest way to get it is to install app `thonny`. You can install it with: `snap install thonny` on ubuntu. thonny is an python IDE ideal for MicroPython.

Get MicroPython firmware: https://micropython.org/download/ESP8266_GENERIC/

```bash
# /snap/thonny/214/bin/python3.10 distribution incl. esptool.py
# erase flash
python3.10 -u -m esptool --port /dev/ttyUSB0 erase_flash
# install micropython
python3.10 -u -m esptool --port /dev/ttyUSB0 --baud 460800 write_flash --flash_size=detect 0 ESP8266_GENERIC-20240105-v1.22.1.bin
```

# Code

Here is an example code snippet to give a preview of MicroPython features.

```python
# put this in boot.py to automatically connect to your WiFi network
def do_connect():
    print('\nconnecting to network (WIFI / WLAN) ...')
    import network
    sta_if = network.WLAN(network.STA_IF)
    if not sta_if.isconnected():
        sta_if.active(True)
        SSID = "<ssid>"
        key = "<pass>"
        sta_if.connect(SSID, key)
        while not sta_if.isconnected():
            pass
    print(f"IP address, netmask, gateway, DNS: {sta_if.ifconfig()}")

# disable or enable access point
def access_point_enable(active):
    print("\naccess point enable: {active}")
    import network
    ap_if = network.WLAN(network.AP_IF)
    print("ap_if.active(): {ap_if.active()}")
    print(f"IP address, netmask, gateway, DNS: {ap_if.ifconfig()}")
    ap_if.active(active)

# make http request
def http_get(url):
    print(f"\nmake http request: {url}")
    import socket
    _, _, host, path = url.split('/', 3)
    addr = socket.getaddrinfo(host, 80)[0][-1]
    s = socket.socket()
    s.connect(addr)
    s.send(bytes('GET /%s HTTP/1.0\r\nHost: %s\r\n\r\n' % (path, host), 'utf8'))
    print("\nRESPONSE\n")
    while True:
        data = s.recv(100)
        if data:
            print(str(data, 'utf8'), end='')
        else:
            break
    s.close()
    
def free_space():
    print("\nshow free space")
    import uos
    try:
        # Attempt to use the statvfs function to get file system status.
        # Note: This function might not be available on all devices.
        fs_stat = uos.statvfs('/')
        # Calculate the block size and the number of free blocks.
        f_bsize = fs_stat[0]
        f_bfree = fs_stat[3]
        # Calculate free space in bytes.
        free_space_bytes = f_bsize * f_bfree
        print("Free space:", free_space_bytes, "bytes")
        print("Free space:", free_space_bytes/1024/1024, "MB")
    except AttributeError:
        print("Function not supported on this device.")

# Define the size of the file to be 512KB
# example size = 512 * 1024  # 512KB
def create_file(size):
    print(f"\ncreate random data random_data.bin with size: {size}")
    import os
    # Open a new file in write-binary ('wb') mode
    with open('random_data.bin', 'wb') as file:
        # Since generating and writing 512KB of data at once might be too much for some devices,
        # we'll do it in smaller chunks. Here, we use 1024 bytes (1KB) chunks.
        chunk_size = 1024
        for _ in range(size // chunk_size):
            # Generate a chunk of random bytes
            chunk = os.urandom(chunk_size)
            # Write the chunk to the file
            file.write(chunk)
    print('File with 512KB of random data created.')
    
def delete_file(name):
    print(f"\ndelete file (folder) name: {name}")
    import os
    try:
        os.remove(name)
        print(f'File {name} deleted successfully.')
    except OSError:
        print(f'Error: File {name} not found or could not be deleted.')

def list_root_directory():
    print(f"\nlist root directory")
    import os
    dirs = os.listdir(".")
    for file in dirs:
       print(file)
       
def system_info():
    import machine
    freq = machine.freq()          # get the current frequency of the CPU
    #machine.freq(160000000) # set the CPU frequency to 160 MHz
    print(f"\nCPU frequency: {freq/1000000} Mhz")
    import os
    print(os.uname())
    import sys
    print(sys.modules.keys())
    import gc
    print(f"free memory: {gc.mem_free()} bytes")

print("# START PROGRAM")

# OS
#delete_file("foo")
#delete_file("random_data.bin")
#create_file(512*2*1024)
free_space()
list_root_directory()

# NETWORK
#do_connect()
#access_point_enable(True)
url = "http://checkip.amazonaws.com/"
http_get(url)

# machine
system_info()

print("# END PROGRAM")
```

# Links
* MicroPython firmware: https://micropython.org/download/ESP8266_GENERIC/
