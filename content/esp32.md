+++
title = "ESP32"
date = 2023-09-15
+++

# ESP32

# About
Programming with ESP32: The ESP32 is a microcontroller widely used in embedded systems and IoT (Internet of Things) applications. This guide provides an introduction to programming with the ESP32, allowing you to harness its capabilities for various projects and IoT innovations.

# System
* Espressif ESP-32 / ESP-WROOM-32 Chipset, NodeMCU Development Board 
* usb-b to usb-a cable
* computer with linux

# Check
Connect SoC (ESP32) with usb cable to computer. Do a check if ESP32 is visible.
```bash
ls -l /dev/ttyUSB*
crw-rw----+ 1 root dialout 188, 0 Sep 15 21:29 /dev/ttyUSB0
```

You may also need to your user to group `dialout` in order to accesible by arduino.
```bash
sudo usermod -a -G dialout <user>
```

# Arduino
* Download Arduino IDE 2.2.1 from Arduino Software.
* Select `ESP32 Dev Module` from the "Boards" menu. This will install the `Platform esp32:esp32@2.0.11.`
* Ensure the Python pyserial module is installed for serial communication. Make sure you install it for the correct Python version, especially if your Arduino IDE uses a different version of Python than your system:

```bash
python3.11 -m pip install pyserial
```

# About the hardware
UART, which stands for Universal Asynchronous Receiver-Transmitter, is used for serial communication.

## Baud

Baud Rate: The baud rate represents the number of __signal units per second__ that are transmitted over a communication channel. 

9600 Baud: This means the signal can change state 9,600 times per second. In the context of UART, it typically means you can transmit 9,600 __bits per second__.

## Data frame
In UART, data is packaged in 8-bit frames, which include a start bit, data bits, an optional parity bit, and stop bit(s).

## System diagram
* TX: Transmit
* RX: Receive

```                                                                                      
 ESP32-WROOM                                                                             Computer           
 +-----------------------------------------------------------------------+               +------------+     
 |                                                                       |               |            |     
 |  +------------+                      +-------------+                  |   USB cable   |            |     
 |  |            |  TX             RX   |             |        USB Port  | <-----------> |  USB Port  |     
 |  |            |  ------------------> |             |                  |    data +     |            |     
 |  |            |                      |             |                  |    power      |            |     
 |  | ESP32 Chip |                      | CP210x Chip |                  |               |            |     
 |  |            |                      | USB-to-UART |                  |               |            |     
 |  |            |  <------------------ |             |                  |               |            |     
 |  |            |  RX             TX   |             |                  |               |            |     
 |  |            |                      |             |                  |               |            |     
 |  +------------+                      +-------------+                  |               |            |     
 |                                                                       |               |            |     
 +-----------------------------------------------------------------------+               +------------+     
```

# Code
Now here we have a code example that you can deploy this code to your ESP32 to scan for nearby WiFi networks endlessly. The results are sent over serial communication, and you can read them in the Arduino IDE's Serial Monitor. Plus, with each scan, the built-in LED on the ESP32 lights up.

```cpp
#include <WiFi.h>

// Define the GPIO pin for the built-in LED
#define LED_PIN 2

void setup() {
  // Initialize Serial communication
  Serial.begin(115200);
  delay(1000); // Give some time for Serial to initialize

  // Print a welcome message
  Serial.println("ESP32 Demonstration Program");

  // Initialize the built-in LED as an output
  pinMode(LED_PIN, OUTPUT);
}

void loop() {
  // Blink the built-in LED
  digitalWrite(LED_PIN, HIGH);
  delay(1000);
  digitalWrite(LED_PIN, LOW);
  delay(1000);

  // Scan for nearby WiFi networks
  Serial.println("Scanning for WiFi networks...");
  int n = WiFi.scanNetworks();
  if (n == 0) {
    Serial.println("No networks found");
  } else {
    Serial.print(n);
    Serial.println(" networks found");
    for (int i = 0; i < n; ++i) {
      // Print SSID and signal strength for each network
      Serial.print(i + 1);
      Serial.print(": ");
      Serial.print(WiFi.SSID(i));
      Serial.print(" (");
      Serial.print(WiFi.RSSI(i));
      Serial.println(" dBm)");
      delay(10);
    }
  }
  delay(5000); // Wait for 5 seconds before scanning again
}
```