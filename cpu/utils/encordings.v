// ALU
`define FORWARD 5'b00000
`define ADD 5'b00001
`define SUB 5'b00010
`define SLL 5'b00011
`define SLT 5'b00100
`define SLTU 5'b00101
`define XOR 5'b00110
`define SRL 5'b00111
`define SRA 5'b01000
`define OR 5'b01001
`define AND 5'b01010
`define MUL 5'b01011
`define MULH 5'b01100
`define MULHSU 5'b01101
`define MULHU 5'b01110
`define DIV 5'b01111
`define DIVU 5'b10000
`define REM 5'b10001
`define REMU 5'b10010

// immediate encoding of the values of the type
`define I_TYPE = 3'b000
`define S_TYPE = 3'b001
`define B_TYPE = 3'b010
`define U_TYPE = 3'b011
`define J_TYPE = 3'b100

// Branch Types
`define BEQ 3'b000
`define BNE 3'b001
`define BLT 3'b100
`define BGE 3'b101
`define BLTU 3'b110
`define BGEU 3'b111