module mux_32b_2to1(
    input [31:0] a,
    input [31:0] b,
    input sel,
    output [31:0] out
);
    assign out = (sel == 1'b1) ? b : a;
endmodule