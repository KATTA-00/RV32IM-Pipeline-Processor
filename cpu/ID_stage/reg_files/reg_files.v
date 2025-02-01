`timescale 1ns/100ps

module reg_files(clk, rst, addr1, addr2, data1, data2, we, wd, waddr);
    input clk, rst, we;
    input [4:0] waddr, addr1, addr2;
    input [31:0] wd;
    output reg [31:0] data1, data2;

    reg [31:0] mem[31:0];

    assign data1 = mem[addr1];
    assign data2 = mem[addr2];

    always @(posedge clk) begin
        if(rst == 1'b1) begin
            for(int i = 0; i < 32; i = i + 1) begin
                mem[i] <= 32'bx;
            end
        end
        else if(we == 1'b1) begin
            mem[waddr] <= wd;
        end
    end

endmodule