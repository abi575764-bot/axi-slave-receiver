```python
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge

@cocotb.test()
async def test_project(dut):

    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0

    dut.rst_n.value = 0
    await RisingEdge(dut.clk)
    dut.rst_n.value = 1

    dut.ui_in.value = 0x55

    await RisingEdge(dut.clk)

    assert dut.uo_out.value == 0x55
```
