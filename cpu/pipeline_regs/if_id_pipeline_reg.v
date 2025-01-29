module if_id_pipeline_reg(clk, rst, pc_in, pc_out, instr_in, instr_out);
    input clk, rst;
    input [31:0] pc_in, instr_in;
    output reg [31:0] pc_out, instr_out;

    always @(posedge clk) begin
        if (rst == 1'b1) begin
            pc_out <= 32'dx;
            instr_out <= 32'dx;
        end
        else begin
            pc_out <= pc_in;
            instr_out <= instr_in;
        end
    end
endmodule