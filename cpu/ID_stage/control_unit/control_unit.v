`include "./utils/mux_3b_2to1.v"
`include "./utils/encordings.v"
`timescale 1ns/100ps

module control_unit(opcode, funct3, funct7, alu_op, reg_write_en, mem_write, mem_read, branch_jump, imm_sel, data1_alu_sel, data2_alu_sel, wb_sel, reset);

    input [6:0] opcode;
    input [2:0] funct3;
    input [6:0] funct7;
    input reset; // reset input and alu comparator signal

    // defining output control signals
    output wire reg_write_en, data1_alu_sel, data2_alu_sel;
    output wire [4:0] alu_op;
    output wire [2:0] mem_write;
    output wire [3:0] mem_read;
    output wire [2:0] branch_jump;
    output wire [3:0] imm_sel;
    output wire [1:0] wb_sel; 

    // decoded instruction segments
    wire funct3_mux_select; // to select the alu signal between func3 and predefined values for JAL & AUIPC

    // ALU control signal genaration
    assign #3 funct3_mux_select = (opcode == `OP_AUIPC) | (opcode == `OP_JAL) | (opcode == `OP_STORE) | (opcode == `OP_LOAD) | (opcode == `OP_BRANCH);
    mux_3b_2to1 funct3_mux (funct3, 3'b000, alu_op[2:0], funct3_mux_select);   
    assign #3 alu_op[4] = ({opcode, funct3, funct7} == {`OP_I_TYPE, 3'b101, 7'b0100000}) | ({opcode, funct3, funct7} == {`OP_R_TYPE, 3'b000, 7'b0100000}) | ({opcode, funct3, funct7} == {`OP_R_TYPE, 3'b101, 7'b0100000}) | (opcode == `OP_LUI);// if SRAI, SUB, SRA, LUI
    assign #3 alu_op[3] = ({opcode, funct7} == {`OP_R_TYPE, 7'b0000001}) | (opcode == `OP_LUI);  // if MUL_inst or LUI
    
    // Register file write signal geraration
    assign #3 reg_write_en = ~((opcode == `OP_STORE) | (opcode == `OP_BRANCH) | (opcode == 7'b0000000)) ;    

    // Main memory write signal genaration
    assign #3 mem_write[2] = (opcode == `OP_STORE);
    assign #3 mem_write[1:0] = funct3[1:0];

    // Main memory read control signal
    assign #3 mem_read[3] = (opcode == `OP_LOAD);
    assign #3 mem_read[2:0] = funct3;

    // branch control signal generation
    assign #3 branch_jump = ((opcode == `OP_JALR) || (opcode == `OP_JAL))?3'b010:funct3; // if JAL or JALR = 010 else funct3 
    
    // Immediate select signal genaration
    assign #3 imm_sel[3] = ({opcode, funct3} == {`OP_LOAD, 3'b100}) | 
                                 ({opcode, funct3} == {`OP_LOAD, 3'b101}) | 
                                 ({opcode, funct3} == {`OP_I_TYPE, 3'b011}) | 
                                 ({opcode, funct3, funct7} == {`OP_R_TYPE, 3'b011, 7'b0000000}) | 
                                 ({opcode, funct3, funct7} == {`OP_R_TYPE, 3'b010, 7'b0000001}) | 
                                 ({opcode, funct3, funct7} == {`OP_R_TYPE, 3'b011, 7'b0000001}) | 
                                 ({opcode, funct3, funct7} == {`OP_R_TYPE, 3'b111, 7'b0000001});

    assign #3 imm_sel[2:0] =  (opcode == `OP_LOAD) ? `IMM_TYPE3 : 
                                    (opcode == `OP_AUIPC) ? `IMM_TYPE1 :
                                    (opcode == `OP_STORE) ? `IMM_TYPE5 : 
                                    (opcode == `OP_LUI) ? `IMM_TYPE1 : 
                                    (opcode == `OP_JAL) ? `IMM_TYPE2 : 
                                    (opcode == `OP_JALR) ? `IMM_TYPE3 : 
                                    (opcode == `OP_BRANCH) ? `IMM_TYPE4 : 
                                    ({opcode, funct3} == {`OP_I_TYPE, 3'bx01}) ? `IMM_TYPE6 : 
                                    (opcode == `OP_I_TYPE) ? `IMM_TYPE3 : 3'bxxx;

    // operand 1 and 2 signal genaration
    assign #3 data1_alu_sel = (opcode == `OP_AUIPC) | (opcode == `OP_JAL) | (opcode == `OP_JALR) | (opcode == `OP_BRANCH); // if AUIPC, JAL, JALR
    //TODO: test the dont care condition.
    assign #3 data2_alu_sel = (opcode == `OP_LOAD) | // all L_inst
                              (opcode == `OP_I_TYPE) | //immediate_inst
                              (opcode == `OP_AUIPC) | //AUIPC
                              (opcode == `OP_STORE) | //S_inst 
                              (opcode == `OP_LUI) | //LUI
                              (opcode == `OP_JALR) | //JAL , 
                              (opcode == `OP_JAL) | //JALR
                              (opcode == `OP_BRANCH) ; //B_inst 

    // Register file write mux select signal genaration
    assign #3 wb_sel[0] = ~(opcode == `OP_LOAD) & ~(opcode == `OP_LUI);
    assign #3 wb_sel[1] = (opcode == `OP_LUI) | (opcode == `OP_JAL) | (opcode == `OP_JALR);


endmodule 