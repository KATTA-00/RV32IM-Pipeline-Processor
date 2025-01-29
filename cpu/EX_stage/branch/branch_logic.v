`include "../../utils/encordings.v"

module branch_logic (
    input wire [31:0] rs1,
    input wire [31:0] rs2,
    input wire [3:0] branch,
    output wire pc_sel_ex
);

    assign pc_sel_ex = branch == `BEQ && rs1 == rs2 ||
                       branch == `BNE && rs1 != rs2 ||
                       branch == `BLT && rs1 < rs2 ||
                       branch == `BGE && rs1 >= rs2 ||
                       branch == `BLTU && $unsigned(rs1) < $unsigned(rs2) ||
                       branch == `BGEU && $unsigned(rs1) >= $unsigned(rs2);
    
endmodule