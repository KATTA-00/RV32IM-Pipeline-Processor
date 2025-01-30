`include "./alu/alu.v"
`include "./branch/branch_logic.v"
`include "../pipeline_regs/ex_mem_pipeline_reg.v"
`include "../utils/mux_32b_2to1.v"
`include "../utils/encordings.v"
`timescale 1ns/100ps

module EX_stage_tb ();
    reg clk, rst, data1alusel_ex_out, data2alusel_ex_out, reg_write_en_ex_out;
    reg [31:0] pc_ex_out, data1_ex_out, data2_ex_out, imm_ex_out;
    reg [4:0] dest_addr_ex_out, aluop_ex_out;
    reg [2:0] branch_jump_ex_out;
    reg [2:0] mem_write_ex_out;
    reg [3:0] mem_read_ex_out;
    reg [1:0] WB_sel_ex_out;

    wire [31:0] data1_mux_out, data2_mux_out, alu_res_out;
    wire branch_logic_out;

    mux_32b_2to1 data1_mux (
        .a(data1_ex_out),
        .b(pc_ex_out),
        .sel(data1alusel_ex_out),
        .out(data1_mux_out)
    );

    mux_32b_2to1 data2_mux (
        .a(data2_ex_out),
        .b(imm_ex_out),
        .sel(data2alusel_ex_out),
        .out(data2_mux_out)
    );

    alu alu_inst (
        .DATA1(data1_mux_out),
        .DATA2(data2_mux_out),
        .SELECT(aluop_ex_out),
        .RESULT(alu_res_out)
    );

    branch_logic branch_logic_inst (
        .data1(data1_ex_out),
        .data2(data2_ex_out),
        .op(branch_jump_ex_out),
        .out(branch_logic_out)
    );

    ex_mem_pipeline_reg ex_mem_pipeline_reg_inst (
        .clk(clk),
        .rst(rst),
        .reg_write_ex_in(reg_write_en_ex_out),
        .pc_ex_in(pc_ex_out),
        .alu_result_ex_in(alu_res_out),
        .read_data2_ex_in(data2_mux_out),
        .imm_ex_in(imm_ex_out),
        .dest_addr_ex_in(dest_addr_ex_out),
        .mem_read_ex_in(mem_read_ex_out),
        .mem_write_ex_in(mem_write_ex_out),
        .WB_sel_ex_in(WB_sel_ex_out),
        .reg_write_mem_out(),
        .pc_mem_out(),
        .alu_result_mem_out(),
        .read_data2_mem_out(),
        .imm_mem_out(),
        .dest_addr_mem_out(),
        .read_write_mem_out(),
        .WB_sel_mem_out()
    );

    initial begin
        $dumpfile("EX_stage_tb.vcd");
        $dumpvars(0, EX_stage_tb);

        // Initialize all inputs
        clk = 0;
        rst = 1;
        data1alusel_ex_out = 0;
        data2alusel_ex_out = 0;
        reg_write_en_ex_out = 0;
        pc_ex_out = 32'h00000000;
        data1_ex_out = 32'h00000000;
        data2_ex_out = 32'h00000000;
        imm_ex_out = 32'h00000000;
        dest_addr_ex_out = 5'b00000;
        aluop_ex_out = 5'b00000;
        branch_jump_ex_out = 3'b000;
        read_write_ex_out = 4'b0000;
        WB_sel_ex_out = 2'b00;

        // Release reset after a few clock cycles
        #10 rst = 0;

        // Test case 1: Simple ALU operation (ADD)
        #10;
        data1_ex_out = 32'h00000001;
        data2_ex_out = 32'h00000002;
        aluop_ex_out = `ADD; // Assuming 5'b00000 is the opcode for ADD
        #10;
        $display("Test case 1: ALU ADD operation");
        $display("data1_ex_out = %h, data2_ex_out = %h, alu_res_out = %h", data1_mux_out, data2_ex_out, alu_res_out);

        // Test case 2: ALU operation with immediate (SUB)
        #10;
        data1_ex_out = 32'h00000005;
        imm_ex_out = 32'h00000002;
        data2alusel_ex_out = 1; // Select immediate
        aluop_ex_out = `SUB; // Assuming 5'b00001 is the opcode for SUB
        #10;
        $display("Test case 2: ALU SUB operation with immediate");
        $display("data1_ex_out = %h, imm_ex_out = %h, alu_res_out = %h", data1_ex_out, imm_ex_out, alu_res_out);

        // Test case 3: Branch logic (BEQ)
        #10;
        data1_ex_out = 32'h00000003;
        data2_ex_out = 32'h00000003;
        branch_jump_ex_out = `BEQ; // Assuming 3'b001 is the opcode for BEQ
        #10;
        $display("Test case 3: Branch logic BEQ");
        $display("data1_ex_out = %h, data2_ex_out = %h, branch_logic_out = %b", data1_ex_out, data2_ex_out, branch_logic_out);

        // Test case 4: Branch logic (BNE)
        #10;
        data1_ex_out = 32'h00000004;
        data2_ex_out = 32'h00000005;
        branch_jump_ex_out = `BNE; // Assuming 3'b010 is the opcode for BNE
        #10;
        $display("Test case 4: Branch logic BNE");
        $display("data1_ex_out = %h, data2_ex_out = %h, branch_logic_out = %b", data1_ex_out, data2_ex_out, branch_logic_out);

        // End simulation
        #10 $finish;
    end

    // Clock generation
    always #5 clk = ~clk;

endmodule