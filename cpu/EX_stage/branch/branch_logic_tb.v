`define TB_RUN
`include "branch_logic.v"

`timescale 1ns/1ps

module branch_logic_tb;

    // Inputs
    reg [31:0] data1, data2;
    reg [2:0] op;

    // Output
    wire out;

    // Instantiate the branch_logic module
    branch_logic uut (
        .data1(data1),
        .data2(data2),
        .op(op),
        .out(out)
    );

    // Testbench logic
    initial begin
        // Test Case 1: BEQ (Branch if Equal)
        data1 = 32'h12345678;
        data2 = 32'h12345678;
        op = `BEQ;
        #10;
        $display("BEQ: data1 = %h, data2 = %h, out = %b", data1, data2, out);

        // Test Case 2: BEQ (Branch if Equal) - Not Equal
        data1 = 32'h12345678;
        data2 = 32'h87654321;
        op = `BEQ;
        #10;
        $display("BEQ: data1 = %h, data2 = %h, out = %b", data1, data2, out);

        // Test Case 3: BNE (Branch if Not Equal)
        data1 = 32'h12345678;
        data2 = 32'h87654321;
        op = `BNE;
        #10;
        $display("BNE: data1 = %h, data2 = %h, out = %b", data1, data2, out);

        // Test Case 4: BNE (Branch if Not Equal) - Equal
        data1 = 32'h12345678;
        data2 = 32'h12345678;
        op = `BNE;
        #10;
        $display("BNE: data1 = %h, data2 = %h, out = %b", data1, data2, out);

        // Test Case 5: BLT (Branch if Less Than) - Signed
        data1 = 32'h80000000; // Negative number
        data2 = 32'h00000001; // Positive number
        op = `BLT;
        #10;
        $display("BLT: data1 = %h, data2 = %h, out = %b", data1, data2, out);

        // Test Case 6: BLT (Branch if Less Than) - Not Less Than
        data1 = 32'h00000001;
        data2 = 32'h80000000;
        op = `BLT;
        #10;
        $display("BLT: data1 = %h, data2 = %h, out = %b", data1, data2, out);

        // Test Case 7: BGE (Branch if Greater Than or Equal) - Signed
        data1 = 32'h00000001;
        data2 = 32'h80000000;
        op = `BGE;
        #10;
        $display("BGE: data1 = %h, data2 = %h, out = %b", data1, data2, out);

        // Test Case 8: BGE (Branch if Greater Than or Equal) - Not Greater Than or Equal
        data1 = 32'h80000000;
        data2 = 32'h00000001;
        op = `BGE;
        #10;
        $display("BGE: data1 = %h, data2 = %h, out = %b", data1, data2, out);

        // Test Case 9: BLTU (Branch if Less Than Unsigned)
        data1 = 32'h00000001;
        data2 = 32'hFFFFFFFF;
        op = `BLTU;
        #10;
        $display("BLTU: data1 = %h, data2 = %h, out = %b", data1, data2, out);

        // Test Case 10: BLTU (Branch if Less Than Unsigned) - Not Less Than
        data1 = 32'hFFFFFFFF;
        data2 = 32'h00000001;
        op = `BLTU;
        #10;
        $display("BLTU: data1 = %h, data2 = %h, out = %b", data1, data2, out);

        // Test Case 11: BGEU (Branch if Greater Than or Equal Unsigned)
        data1 = 32'hFFFFFFFF;
        data2 = 32'h00000001;
        op = `BGEU;
        #10;
        $display("BGEU: data1 = %h, data2 = %h, out = %b", data1, data2, out);

        // Test Case 12: BGEU (Branch if Greater Than or Equal Unsigned) - Not Greater Than or Equal
        data1 = 32'h00000001;
        data2 = 32'hFFFFFFFF;
        op = `BGEU;
        #10;
        $display("BGEU: data1 = %h, data2 = %h, out = %b", data1, data2, out);

        // Test Case 13: JAL_JALR (Always True)
        data1 = 32'h12345678;
        data2 = 32'h87654321;
        op = `JAL_JALR;
        #10;
        $display("JAL_JALR: data1 = %h, data2 = %h, out = %b", data1, data2, out);

        // End simulation
        $finish;
    end

endmodule