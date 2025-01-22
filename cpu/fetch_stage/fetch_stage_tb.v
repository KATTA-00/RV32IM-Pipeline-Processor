`include "pc.v"
`include "pc_mux.v"
`include "pc_adder.v"
`include "../pipeline_regs/if_id_pipeline_reg.v"
`include "../utils/mux_32b_2to1.v"
`include "../utils/adder_32b_4.v"
`include "imem.v"
`timescale 1ns/100ps

module fetch_stage_tb;
    reg clk, rst, pc_sel_ex;
    reg [31:0] pc_ex;
    wire [31:0] pc_mux_out, pc_out, pc_next, instr_out, pc_out_dec, instr_out_dec;

    pc pc(
        .clk(clk), 
        .rst(rst), 
        .pc_in(pc_mux_out), 
        .pc_out(pc_out)
    );

    pc_mux mux_32b_2to1(
        .a(pc_out), 
        .b(pc_ex), 
        .sel(pc_sel_ex), 
        .out(pc_mux_out)
    );

    pc_adder adder_32b_4(
        .data(pc_out), 
        .out(pc_ex)
    );

    imem imem(
        .clk(clk), 
        .rst(rst), 
        .pc(pc_out), 
        .instr(instr_out)
    );   
     
    if_id_pipeline_reg if_id_pipeline_reg(
        .clk(clk), 
        .rst(rst), 
        .pc_in(pc_out), 
        .pc_out(pc_out_dec), 
        .instr_in(instr_out), 
        .instr_out(instr_out_dec)
    );

    initial begin
        $dumpfile("fetch_stage_tb.vcd");
        $dumpvars(0, fetch_stage_tb);
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
       