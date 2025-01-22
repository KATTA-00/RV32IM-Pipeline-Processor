`include "../utils/encodings.v"

module sign_ext(imm, imm_ext, imm_sel);
    input [24:0] imm;
    output [31:0] imm_ext;
    input [2:0] imm_sel;

    case (imm_sel)
        // I-type
        I_TYPE: assign imm_ext = {{21{imm[24]}}, imm[23:18], imm[17:14], imm[13]};
        // S-type
        S_TYPE: assign imm_ext = {{21{imm[24]}}, imm[23:18], imm[4:1], imm[0]};
        // B-type
        B_TYPE: assign imm_ext = {{21{imm[24]}}, imm[0], imm[23:18], imm[4:1], 1'b0};
        // U-type
        U_TYPE: assign imm_ext = {imm[24], imm[23:13], imm[12:5], 12'b0};
        // J-type
        J_TYPE: assign imm_ext = {{12{imm[24]}}, imm[12:5], imm[13], imm[23:18], imm[17:14]};
        default: assign imm_ext = 32'b0;
    endcase
endmodule