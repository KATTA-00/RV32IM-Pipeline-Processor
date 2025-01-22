`timescale 1ps/1ps
`include "pc.v"
`include "pc_mux.v"
`include "pc_adder.v"
`include "fetch_reg.v"
`include "imem.v"

module fetch_cycle_tb;
    reg clk, rst, pc_sel_ex;
    reg [31:0] pc_ex;
    wire [31:0] pc_mux_out, pc_out, pc_next, instr_out, pc_out_dec, instr_out_dec;

    pc pc(
        .clk(clk), 
        .rst(rst), 
        .pc_in(pc_mux_out), 
        .pc_out(pc_out)
    );
    pc_mux pc_mux(
        .pc_next(pc_next), 
        .pc_ex(pc_ex), 
        .sel(pc_sel_ex), 
        .pc(pc_mux_out)
    );
    pc_adder pc_adder(
        .pc(pc_out), 
        .pc_next(pc_next)
    );
    imem imem(
        .clk(clk), 
        .rst(rst), 
        .pc(pc_out), 
        .instr(instr_out)
    );    
    fetch_reg fetch_reg(
        .clk(clk), 
        .rst(rst), 
        .pc_in(pc_out), 
        .pc_out(pc_out_dec), 
        .instr_in(instr_out), 
        .instr_out(instr_out_dec)
    );

    initial begin
        $dumpfile("fetch_cycle_tb.vcd");
        $dumpvars(0, fetch_cycle_tb);
        clk = 1'b0;
        rst = 1'b0;
        pc_sel_ex = 1'b0;
        pc_ex = 32'h0;
        #5
        rst = 1'b1;
        #10
        rst = 1'b0;
        #500
        $finish;
    end

    always begin
        #10 clk = ~clk;
    end
    
endmodule
       