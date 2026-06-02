```verilog
`default_nettype none
`timescale 1ns / 1ps

module tb ();

  initial begin
    $dumpfile("tb.fst");
    $dumpvars(0, tb);
  end

  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  reg [7:0] uio_in;

  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

  tt_um_example user_project (
`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif
      .ui_in(ui_in),
      .uo_out(uo_out),
      .uio_in(uio_in),
      .uio_out(uio_out),
      .uio_oe(uio_oe),
      .ena(ena),
      .clk(clk),
      .rst_n(rst_n)
  );

  // Clock generation
  initial begin
      clk = 0;
      forever #5 clk = ~clk;
  end

  // Test sequence
  initial begin

      ena = 1'b1;
      rst_n = 1'b0;
      ui_in = 8'b0;
      uio_in = 8'b0;

      #20;
      rst_n = 1'b1;

      // Write Address = 0
      ui_in[7:3] = 5'b00000;

      // AWVALID = 1
      ui_in[0] = 1'b1;

      // WVALID = 1
      ui_in[1] = 1'b1;

      // Data = 0x55
      uio_in = 8'h55;

      @(posedge clk);

      ui_in[0] = 1'b0;
      ui_in[1] = 1'b0;

      #20;

      $display("Output Data = %h", uo_out);

      // Complete response
      ui_in[2] = 1'b1; // BREADY

      @(posedge clk);

      ui_in[2] = 1'b0;

      #20;

      $finish;
  end

endmodule
```
