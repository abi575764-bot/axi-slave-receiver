```verilog
/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    
    output wire [7:0] uo_out,   
    input  wire [7:0] uio_in,   
    output wire [7:0] uio_out,  
    output wire [7:0] uio_oe,   
    input  wire       ena,      
    input  wire       clk,      
    input  wire       rst_n     
);

    // AXI-Lite simplified signals
    wire        awvalid = ui_in[0];
    wire        wvalid  = ui_in[1];
    wire        bready  = ui_in[2];
    wire [4:0]  awaddr  = ui_in[7:3];

    wire [7:0]  wdata = uio_in;

    reg [7:0] slave_reg;
    reg bvalid;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            slave_reg <= 8'h00;
            bvalid <= 1'b0;
        end
        else begin
            if (awvalid && wvalid) begin
                case (awaddr)
                    5'b00000: slave_reg <= wdata;
                    default:  slave_reg <= slave_reg;
                endcase

                bvalid <= 1'b1;
            end

            if (bvalid && bready)
                bvalid <= 1'b0;
        end
    end

    // Output stored data
    assign uo_out = slave_reg;

    // Unused bidirectional outputs
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

    // Prevent warnings
    wire _unused = &{ena, 1'b0};

endmodule
```
