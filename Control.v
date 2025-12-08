module Control
( // Do not modify port names
    input  [6:0] op_i,
    output       ALUSrc_o,
    output       RegWrite_o,
    output [1:0] ALUOp_o
);

reg       ALUSrc_r;
reg       RegWrite_r;
reg [1:0] ALUOp_r;

always @(*) begin
    ALUSrc_r   = 1'b0;
    RegWrite_r = 1'b0;
    ALUOp_r    = 2'b00;
    case (op_i)
        7'b0110011: begin // R-type
            ALUSrc_r   = 1'b0;
            RegWrite_r = 1'b1;
            ALUOp_r    = 2'b10;
        end
        7'b0010011: begin // I-type
            ALUSrc_r   = 1'b1;
            RegWrite_r = 1'b1;
            ALUOp_r    = 2'b11;
        end
        default: begin
            ALUSrc_r   = 1'b0;
            RegWrite_r = 1'b0;
            ALUOp_r    = 2'b00;
        end
    endcase
end

assign ALUSrc_o   = ALUSrc_r;
assign RegWrite_o = RegWrite_r;
assign ALUOp_o    = ALUOp_r;

endmodule
