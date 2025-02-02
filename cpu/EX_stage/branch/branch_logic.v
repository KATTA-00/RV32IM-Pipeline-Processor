`ifdef TB_RUN
    `include "../../utils/encordings.v"
`else
    `include "./utils/encordings.v"
`endif


module branch_logic (
    input wire [31:0] data1,
    input wire [31:0] data2,
    input wire [2:0] op,
    output wire out
);

    assign #2  out = (op == `BEQ && (data1 == data2)) ||
                 (op == `BNE && (data1 != data2)) ||
                 (op == `BLT && ($signed(data1) < $signed(data2))) || 
                 (op == `BGE && ($signed(data1) >= $signed(data2))) || 
                 (op == `BLTU && ($unsigned(data1) < $unsigned(data2))) ||
                 (op == `BGEU && ($unsigned(data1) >= $unsigned(data2))) ||
                 (op == `JAL_JALR);
    
endmodule