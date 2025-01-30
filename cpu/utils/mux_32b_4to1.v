module mux_32b_4to1(
    input [31:0] a,  // 32-bit input A
    input [31:0] b,  // 32-bit input B
    input [31:0] c,  // 32-bit input C
    input [31:0] d,  // 32-bit input D
    output [31:0] out, // 32-bit output
    input [1:0] sel   // 2-bit select signal
);

    // The output is assigned based on the value of sel
    assign out = (sel == 2'b00) ? a :
                 (sel == 2'b01) ? b :
                 (sel == 2'b10) ? c :
                 (sel == 2'b11) ? d :
                 32'b0; // Default case (optional, can be omitted)

endmodule