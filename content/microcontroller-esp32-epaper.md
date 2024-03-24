+++
title = "Microcontroller: ESP32 - e-Paper / E-Ink"
date = 2023-09-16
+++

# About
This document gives an overview how to developer esp32 with a connected epaper (E-Ink).

# Requirements
* Espressif ESP-32 / ESP-WROOM-32 Chipset, NodeMCU Development Board 
* usb-b to usb-a cable
* computer with linux
* epaper: waveshare
    * 200x200, 1.54inch E-Ink display module, three-color, SPI interface | `WFT0000CZ04` 
    * SKU: 13338 
    * 1.54inch e-Paper Module (B) 
* ide: arduino ide
    
> arduino also provides the option to install libraries: open menu > Manage Libraries ... > install `EPD`, `GxEPD`, `GxEPD2` on demand. These libs provides also code example that you can access with menu > File > Example > `Examples from Custom Libraries`.

# Interface

Here is a reference of the pins.

```
| SYMBOL | DESCRIPTION                                                  |
| ------ | ------------------------------------------------------------ |
| VCC    | 3.3V/5V                                                      |
| GND    | Ground                                                       |
| DIN    | SPI MOSI pin                                                 |
| CLK    | SPI SCK pin, SCL                                             |
| CS     | SPI chip selection, low active, chip enable, SS slave select |
| DC     | Data/Command selection (high for data, low for command)      |
| RST    | External reset, low active                                   |
| BUSY   | Busy status output, low active                               |

Serial Data (SDA) and Serial Clock (SCL)
```

Source: https://www.waveshare.com/1.54inch-e-paper-module-b.htm

# Example: GxEPD2

Library `GxEPD2` provides an example: `GxEPD2_WS_ESP32_Driver.ino`.
In Ardiuno you can install it as library.

In code set following values to apply for waveshare 1.54inch e-Paper Module (B) 
```cpp
DISPLAY_CLASS = GxEPD2_3C
DRIVER_CLASS = GxEPD2_154_Z90c
```

# Example: waveshare
Waveshare also provides an example `epd1in54b_V2-demo.ino`.

# Wiring

Wiring example from: https://www.waveshare.com/wiki/E-Paper_ESP32_Driver_Board
```
Pin 	ESP32 	Description
VCC 	3V3 	Power input (3.3V)                              gray
GND 	GND 	Ground                                          brown
DIN 	P14 	SPI MOSI pin, data input                        blue
SCLK 	P13 	SPI CLK pin, clock signal input                 yellow
CS 	    P15 	Chip selection, low active                      orange
DC 	    P27 	Data/command, low for commands, high for data   green
RST 	P26 	Reset, low active                               white
BUSY 	P25 	Busy status output pin (means busy)             violet
```

# Sources
* https://www.waveshare.com/wiki/1.54inch_e-Paper_Module_(B)
* https://www.waveshare.com/wiki/E-Paper_ESP32_Driver_Board