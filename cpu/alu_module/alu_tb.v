`timescale 1ns/100ps
`include "alu.v"

module alu_tb;

    reg signed [31:0] data1, data2;
    reg [4:0] select;
    wire signed [31:0] result;

    alu test_alu(data1, data2, select, result);

    initial begin
        data1 = 1;
        data2 = 2;
        select = 1;

        #10
        data1 = 5;
        data2 = 2;
        select = 1;

        #10
        data1 = 4;
        data2 = -2;
        select = 2;
    end


    initial begin
        $monitor($time, " | data1 = %d, data2 = %d, select = %d | result = %d", data1, data2, select, result);
    end


endmodule