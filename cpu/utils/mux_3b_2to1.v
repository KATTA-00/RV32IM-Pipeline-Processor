module mux_3b_2to1(
    input [2:0] a,
    input [2:0] b,
    input sel,
    output [2:0] out
);
    assign out = (sel == 1'b1) ? b : a;
endmodule