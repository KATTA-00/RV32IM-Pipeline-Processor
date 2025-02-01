`include "./utils/encordings.v"

module branch_logic (
    input wire [31:0] data1,
    input wire [31:0] data2,
    input wire [2:0] op,
    output wire out
);

    assign out = (op == `BEQ && (data1 == data2)) ||
                       (op == `BNE && (data1 != data2)) ||
                       (op == `BLT && (data1 < data2)) ||
                       (op == `BGE && (data1 >= data2)) ||
                       (op == `BLTU && ($unsigned(data1) < $unsigned(data2))) ||
                       (op == `BGEU && ($unsigned(data1) >= $unsigned(data2))) ||
                       op == `JAL_JALR;
    
endmodule