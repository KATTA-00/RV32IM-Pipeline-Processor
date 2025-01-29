module ex_mem_pipeline_reg(
    input clk, reset, reg_write_ex_in,
    input [31:0] dest_addr_ex_in, pc_ex_in, alu_result_ex_in, read_data2_ex_in, imm_ex_in,
    input [3:0] read_write_ex_in,
    input [1:0] WB_sel_in,
    output reg reg_write_ex_out,
    output reg [31:0] dest_addr_ex_out, pc_ex_out, alu_result_ex_out, read_data2_ex_out, imm_ex_out,
    output reg [3:0] read_write_ex_out,
    output reg [1:0] WB_sel_out
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            reg_write_ex_out <= 1'b0;
            dest_addr_ex_out <= 32'b0;
            pc_ex_out <= 32'b0;
            alu_result_ex_out <= 32'b0;
            read_data2_ex_out <= 32'b0;
            imm_ex_out <= 32'b0;
            read_write_ex_out <= 4'b0;
            WB_sel_out <= 2'b0;
        end
        else begin
            reg_write_ex_out <= reg_write_ex_in;
            dest_addr_ex_out <= dest_addr_ex_in;
            pc_ex_out <= pc_ex_in;
            alu_result_ex_out <= alu_result_ex_in;
            read_data2_ex_out <= read_data2_ex_in;
            imm_ex_out <= imm_ex_in;
            read_write_ex_out <= read_write_ex_in;
            WB_sel_out <= WB_sel_in;
        end
    end

endmodule