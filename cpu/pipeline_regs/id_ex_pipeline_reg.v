module id_ex_pipeline_reg(
    input clk, rst,
    input reg_write_en_id_in, data1_alu_sel_id_in, data2_alu_sel_id_in,
    input [31:0] pc_id_in, read_data1_id_in, read_data2_id_in, imm_id_in,
    input [4:0] dest_addr_id_in, aluop_id_in,
    input [2:0] mem_write_id_in, branch_jump_id_in,
    input [3:0] mem_read_id_in,
    input [1:0] wb_sel_id_in,
    output reg reg_write_en_ex_out, data1_alu_sel_ex_out, data2_alu_sel_ex_out,
    output reg [31:0] pc_ex_out, read_data1_ex_out, read_data2_ex_out, imm_ex_out,
    output reg [4:0] dest_addr_ex_out, aluop_ex_out,
    output reg [2:0] mem_write_ex_out, branch_jump_ex_out,
    output reg [3:0] mem_read_ex_out,
    output reg [1:0] wb_sel_ex_out
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            reg_write_en_ex_out <= 0;
            data1_alu_sel_ex_out <= 0;
            data2_alu_sel_ex_out <= 0;
            pc_ex_out <= 0;
            read_data1_ex_out <= 0;
            read_data2_ex_out <= 0;
            imm_ex_out <= 0;
            dest_addr_ex_out <= 0;
            aluop_ex_out <= 0;
            mem_write_ex_out <= 0;
            branch_jump_ex_out <= 0;
            mem_read_ex_out <= 0;
            wb_sel_ex_out <= 0;
        end else begin
            reg_write_en_ex_out <= reg_write_en_id_in;
            data1_alu_sel_ex_out <= data1_alu_sel_id_in;
            data2_alu_sel_ex_out <= data2_alu_sel_id_in;
            pc_ex_out <= pc_id_in;
            read_data1_ex_out <= read_data1_id_in;
            read_data2_ex_out <= read_data2_id_in;
            imm_ex_out <= imm_id_in;
            dest_addr_ex_out <= dest_addr_id_in;
            aluop_ex_out <= aluop_id_in;
            mem_write_ex_out <= mem_write_id_in;
            branch_jump_ex_out <= branch_jump_id_in;
            mem_read_ex_out <= mem_read_id_in;
            wb_sel_ex_out <= wb_sel_id_in;
        end
    end

endmodule
