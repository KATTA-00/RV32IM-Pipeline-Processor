module adder_32b_4(
    input [31:0] data,
    output [31:0] out
);

    assign out = data + 4;

endmodule