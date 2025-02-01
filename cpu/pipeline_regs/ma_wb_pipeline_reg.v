`timescale 1ns/100ps

module ma_wb_pipeline_reg(
    input clk, rst,
    input reg_write_ma_in,
    input [31:0] pc_ma_in, mem_data_ma_in, alu_out_ma_in, imm_ma_in,
    input [4:0] dest_addr_ma_in, 
    input [1:0] wb_sel_ma_in,
    input busywait,
    output reg reg_write_wb_out,
    output reg [31:0] pc_wb_out, mem_data_wb_out, alu_out_wb_out, imm_wb_out,
    output reg [4:0] dest_addr_wb_out,
    output reg [1:0] wb_sel_wb_out
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            #1
            reg_write_wb_out <= 1'b0;
            pc_wb_out <= 32'b0;
            mem_data_wb_out <= 32'b0;
            alu_out_wb_out <= 32'b0;
            imm_wb_out <= 32'b0;
            dest_addr_wb_out <= 32'b0;
            wb_sel_wb_out <= 2'b0;
        end else begin
            if (!busywait) begin
            #1
            reg_write_wb_out <= reg_write_ma_in;
            pc_wb_out <= pc_ma_in;
            mem_data_wb_out <= mem_data_ma_in;
            alu_out_wb_out <= alu_out_ma_in;
            imm_wb_out <= imm_ma_in;
            dest_addr_wb_out <= dest_addr_ma_in;
            wb_sel_wb_out <= wb_sel_ma_in;  
            end
        end
    end
endmodule