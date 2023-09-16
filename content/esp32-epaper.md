+++
title = "ESP32 - e-Paper / E-Ink"
date = 2023-09-16
+++

# About
This document gives an overview how to developer esp32 with a connected epaper (E-Ink).

# Hardware
* Espressif ESP-32 / ESP-WROOM-32 Chipset, NodeMCU Development Board 
* waveshare epaper
    * SKU: 13338 
    * 1.54inch e-Paper Module (B) 
    * 200x200, 1.54inch E-Ink display module, three-color
* usb-b to usb-a cable
* computer with linux
* programming of esp32 with arduino or compareable
    
> arduino also provides the option to install libraries: open menu > Manage Libraries ... > install `EPD`, `GxEPD`, `GxEPD2` on demand. These libs provides also code example that you can access with menu > File > Example > `Examples from Custom Libraries`.

# Interface

Here is a reference of the pins.

```
| SYMBOL | DESCRIPTION                                        |
| ------ | -------------------------------------------------- |
| VCC    | 3.3V/5V                                            |
| GND    | Ground                                             |
| DIN    | SPI MOSI pin                                       |
| CLK    | SPI SCK pin                                        |
| CS     | SPI chip selection, low active                     |
| DC     | Data/Command selection (high for data, low for command) |
| RST    | External reset, low active                         |
| BUSY   | Busy status output, low active                     |
```
Source: https://www.waveshare.com/1.54inch-e-paper-module-b.htm

# Example
Waveshare provides a wifi demo ~> `Loader_esp32wf` that you can use to get started:
* https://www.waveshare.com/wiki/E-Paper_ESP32_Driver_Board#Download_Demo
* https://files.waveshare.com/upload/5/50/E-Paper_ESP32_Driver_Board_Code.7z

In this demo, a server is loaded onto the ESP32, allowing you to drag and drop an image in 200x200 size and upload it to the e-paper display.

To setup the demo, load the example in arduino IDE > Open ... > `Loader_esp32wf.ino`. Then edit wifi configuration in `srvr.h`:
```cpp
/* SSID and password of your WiFi net ----------------------------------------*/
const char *ssid = ""; //"your ssid";
const char *password = "";   //"your password";

/* Static IP address Settings ------------------------------------------------*/
IPAddress staticIP(192, 168, 178, 111);
IPAddress gateway(192, 168, 178, 1);
IPAddress subnet(255, 255, 255, 0);
IPAddress dns(192, 168, 178, 1);
```

Ensure that your wiring aligns with the definitions in `epd.h`:
```cpp
#define PIN_SPI_SCK  13
#define PIN_SPI_DIN  14
#define PIN_SPI_CS   15
#define PIN_SPI_BUSY 25//19
#define PIN_SPI_RST  26//21
#define PIN_SPI_DC   27//22
```

# Wiring
Here's how you should connect the components:
```
| Component | ESP32 Pin |
| --------- | --------- |
| BUSY      | G25       |
| RST       | G26       |
| DC        | G27       |
| CS        | G15       |
| CLK       | G13       |
| DIN       | G14       |
| GND       | GND       |
| VCC       | 3V3       |
```

# Sources
* https://www.waveshare.com/wiki/1.54inch_e-Paper_Module_(B)
* https://www.waveshare.com/wiki/E-Paper_ESP32_Driver_Board