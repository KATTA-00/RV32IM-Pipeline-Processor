`include "mux32.v"
`timescale 1ns/1ps

module mux32_tb ();
    reg [31:0] a, b;
    reg sel;
    wire [31:0] y;

    mux32 mux32_inst (
        .a(a),
        .b(b),
        .sel(sel),
        .y(y)
    );

    initial begin
        $dumpfile("mux32_tb.vcd");
        $dumpvars(0, mux32_tb);

        a = 32'h00000000;
        b = 32'h00000001;
        sel = 1'b0;
        #10;
        sel = 1'b1;
        #10;
        sel = 1'b0;
        #10;
        sel = 1'b1;
        #10;
    end

endmodule