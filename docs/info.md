# How it works

This project implements a simplified AXI4-Lite Slave Receiver using Verilog. The design accepts write address and write data inputs through a reduced AXI-like interface suitable for Tiny Tapeout's limited I/O pins.

When both AWVALID and WVALID are asserted, the slave captures the incoming write data and stores it in an internal register. The stored value is continuously displayed on the output pins. The design demonstrates the basic concepts of AXI slave communication, including VALID/READY handshaking and register-based data storage.

# How to test

1. Apply reset by driving `rst_n` low.
2. Release reset by driving `rst_n` high.
3. Set the write address on `ui_in[7:3]`.
4. Apply write data on `uio_in[7:0]`.
5. Assert `AWVALID` (`ui_in[0]`) and `WVALID` (`ui_in[1]`).
6. Wait for a rising edge of the clock.
7. Observe the stored value on `uo_out[7:0]`.
8. Assert `BREADY` (`ui_in[2]`) to complete the write response transaction.

Example:

* Address = 0x00
* Data = 0x55
* AWVALID = 1
* WVALID = 1

After a clock edge, the output should display 0x55.

# External hardware

No external hardware is required.

The project uses only the Tiny Tapeout input, output, clock, and reset pins. Testing can be performed entirely in simulation or on a Tiny Tapeout chip without additional peripherals.
