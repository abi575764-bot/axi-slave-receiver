<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

# AXI4-Stream Receiver

## How it works

This project implements a simplified AXI4-Stream receiver.

Incoming 8-bit data is applied to the input pins and sampled on the rising edge of the clock. The received value is stored in an internal register and driven to the output pins.

The design demonstrates the basic concept of receiving streaming data synchronized to a clock.

## How to test

1. Apply reset.
2. Drive an 8-bit value on the input pins.
3. Wait for a rising clock edge.
4. Observe the same value on the output pins.

Example:

| Input | Output |
| ----- | ------ |
| 0x55  | 0x55   |
| 0xAA  | 0xAA   |
| 0xF0  | 0xF0   |

## External hardware

No external hardware is required.
