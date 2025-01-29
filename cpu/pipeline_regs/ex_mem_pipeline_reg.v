module ex_mem_pipeline_reg(
    input clk, rst, reg_write_ex_in,
    input [31:0] pc_ex_in, alu_result_ex_in, read_data2_ex_in, imm_ex_in,
    input [4:0] dest_addr_ex_in,
    input [3:0] read_write_ex_in,
    input [1:0] WB_sel_ex_in,
    output reg reg_write_mem_out,
    output reg [31:0] pc_mem_out, alu_result_mem_out, read_data2_mem_out, imm_mem_out,
    output reg [4:0] dest_addr_mem_out,
    output reg [3:0] read_write_mem_out,
    output reg [1:0] WB_sel_mem_out
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            reg_write_mem_out <= 1'b0;
            dest_addr_mem_out <= 32'b0;
            pc_mem_out <= 32'b0;
            alu_result_mem_out <= 32'b0;
            read_data2_mem_out <= 32'b0;
            imm_mem_out <= 32'b0;
            read_write_mem_out <= 4'b0;
            WB_sel_mem_out <= 2'b0;
        end
        else begin
            reg_write_mem_out <= reg_write_ex_in;
            dest_addr_mem_out <= dest_addr_ex_in;
            pc_mem_out <= pc_ex_in;
            alu_result_mem_out <= alu_result_ex_in;
            read_data2_mem_out <= read_data2_ex_in;
            imm_mem_out <= imm_ex_in;
            read_write_mem_out <= read_write_ex_in;
            WB_sel_mem_out <= WB_sel_ex_in;
        end
    end

endmodule