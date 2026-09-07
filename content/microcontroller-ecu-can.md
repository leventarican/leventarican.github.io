+++
title = "Microcontroller: ECU-CAN"
date = 2026-09-04
+++

# About
`ecu-can` is a small hardware project: two microcontroller boards talk to each other over CAN bus, the same kind of communication bus that connects the different computers ("ECUs" — Electronic Control Units) inside a car. My two boards play the role of two ECUs sending simple messages back and forth. The point of the project is to learn embedded programming close to the metal — writing directly to the chip's hardware registers instead of using ready-made libraries — and to actually see the electrical signals on the wire with a logic analyzer, not just trust that the code "should" work.

# The bigger question behind it
The underlying question I want to get to is a simple one: how does a system know where it is and which way it's pointing, reliably, while it's moving? A car, a drone, a survey device on a tripod — they all answer that with the same basic idea: combine a fast but drifting sensor (a gyroscope/accelerometer, the IMU) with a slower but absolute one (GPS, the GNSS) and fuse the two together. That's the direction this project is slowly walking toward, one phase at a time. Right now there's no sensor fusion yet — just two boards and a CAN bus — but everything below is a building block toward it.

# Hardware
* 2x NUCLEO-F446RE — a beginner-friendly development board from ST, with the microcontroller itself (an STM32F446RE, an ARM chip clocked at 180MHz with 512KB of flash memory and 128KB of RAM) plus a built-in USB debugger/programmer, so no extra programmer hardware is needed
* 2x SN65HVD230 — small "CAN transceiver" boards. A microcontroller alone can't drive a CAN bus directly; the transceiver converts the chip's digital signal into the two-wire differential signal (called CAN_H and CAN_L) that actually goes out on the bus
* 1x USB logic analyzer — a small device that samples digital signals many times per second and shows them on the computer, so you can see the actual bits going over the wire

# The plan
The project is split into phases, each one building on the last: getting a single board running, connecting two boards over CAN, adding a simulated sensor pipeline, adding an RTOS (a small real-time operating system), adding real sensors, and finally some safety patterns. So far, the first two phases are done.

__Phase 1 — getting one board running__
* Blink the onboard LED — but without any library, by writing directly to the chip's registers: turn on the clock for the LED's GPIO pin, set the pin to "output" mode, and toggle it in a loop
* Same blink, but driven by a hardware timer with an interrupt instead of a loop that just wastes CPU cycles counting — the chip can go to sleep between blinks and wake up only when the timer fires
* Get the serial connection working: the board can send text ("Hello World") to the computer over USB, printed every 2 seconds

__Phase 2 — two boards talking over CAN__
* Wire each board to its own CAN transceiver board
* Connect the two transceiver boards together via CAN_H and CAN_L — this is the actual "bus" both boards share
* Configure the chip's built-in CAN controller by hand (again, no library): set the speed to 500 kbit/s and tell it to accept all incoming messages
* Board 1 sends a small counter value as a message every 500ms; board 2 receives it and blinks its LED every time a message arrives — both boards run the exact same firmware and can send and receive at the same time
* Double-checked with the logic analyzer: over a 3 second recording, 12 messages came through, all correctly acknowledged, no errors

# Looking at the bus with a logic analyzer
CAN_H and CAN_L are a differential pair — the signal is the small voltage *difference* between the two wires, not a clean 0V/3.3V digital level, so a basic logic analyzer struggles to read them directly. The easier tap point turned out to be the RXD pin on the transceiver board: there, the signal is already converted back into a clean digital signal, and — as a bonus — it shows *all* traffic on the bus, not just what one board happens to be sending.

```sh
sigrok-cli --driver fx2lafw --config samplerate=8M --time 3000ms --channels D0 \
    --output-file captures/can-heartbeat.sr

sigrok-cli -i captures/can-heartbeat.sr \
    -P can:can_rx=D0:nominal_bitrate=500000
```

In PulseView (the graphical version of the same tool), you add a "CAN" decoder, point it at the recorded channel, and set the bitrate to 500 kbit/s to match the firmware. Zoomed into a single message, every part of it is labeled: start of frame, message ID, length, the actual data bytes, a checksum, and the acknowledgment bit.

# Building and flashing
Compiling and uploading the firmware is a plain `make`:

```sh
cd workspace/phase2-can-basic
make          # compiles the code, prints how much flash/RAM it uses
make flash    # uploads the program to the board and restarts it
```

A few small helper scripts round out the day-to-day work: one checks whether a board is even detected over USB, one reads the CAN status registers live so bus errors are visible immediately, and two more back up and restore a board's flash memory — useful before overwriting a board with new firmware, in case you want the original back.

# What's next
Phase 3 adds a simulated sensor value on the computer, sent to board 1, processed and forwarded over CAN to board 2, and the result sent back to the computer — a small round trip visible live on screen, standing in for the real sensor data until the next phase.

Phase 4 brings in the two real sensors: a motion sensor (IMU) over I2C and a GPS module (GNSS) over UART. Both need their own driver, calibration, and a way to notice bad or missing readings.

Phase 5 is where it comes together: FreeRTOS instead of one big main loop, so the sensor reading, the fusion math, and the CAN sending can run as separate tasks — and a filter (complementary or Kalman) that combines the IMU and GNSS readings into one steadier estimate of position and orientation. That result goes out over CAN, back to the same bus phase 2 already proved works.

After that it's mostly writing things down: a proper README, a diagram, and a short demo — for example spinning the board on a turntable and watching its computed orientation change live in the CAN log.
