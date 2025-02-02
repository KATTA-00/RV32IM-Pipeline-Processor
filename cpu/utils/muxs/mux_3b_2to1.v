`timescale 1ns/100ps

module mux_3b_2to1(
    input [2:0] a,
    input [2:0] b,
    output [2:0] out,
    input sel
);
    assign out = (sel == 1'b1) ? b : a;
endmodule