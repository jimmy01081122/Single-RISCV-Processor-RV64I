module Imm_Gen
( // Do not modify port names
    input  [31:0] instr_i,
    output [63:0] Imm_o
);

assign Imm_o = {{52{instr_i[31]}}, instr_i[31:20]};

endmodule
