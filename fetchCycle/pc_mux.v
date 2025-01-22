module pc_mux(pc_next, pc_ex, sel, pc);
    input [31:0] pc_next, pc_ex;
    input sel;
    output [31:0] pc;

    assign pc = (sel == 1'b1) ? pc_ex : pc_next;
endmodule