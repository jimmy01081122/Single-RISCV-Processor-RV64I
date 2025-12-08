module ALU_Control
( // Do not modify port names
    input      [6:0] funct7_i,
    input      [2:0] funct3_i,
    input      [1:0] ALUOp_i,
    output reg [3:0] ALUCtrl_o
);

    localparam ALU_ADD = 4'b0000;
    localparam ALU_SUB = 4'b0001;
    localparam ALU_AND = 4'b0010;
    localparam ALU_OR  = 4'b0011;
    localparam ALU_XOR = 4'b0100;
    localparam ALU_SLL = 4'b0101;
    localparam ALU_SRL = 4'b0110;
    localparam ALU_SRA = 4'b0111;

    always @(*) begin
        case (ALUOp_i)
            2'b10: begin // R-type
                case ({funct7_i, funct3_i})
                    {7'b0000000, 3'b000}: ALUCtrl_o = ALU_ADD;
                    {7'b0100000, 3'b000}: ALUCtrl_o = ALU_SUB;
                    {7'b0000000, 3'b100}: ALUCtrl_o = ALU_XOR;
                    {7'b0000000, 3'b110}: ALUCtrl_o = ALU_OR;
                    {7'b0000000, 3'b111}: ALUCtrl_o = ALU_AND;
                    {7'b0000000, 3'b001}: ALUCtrl_o = ALU_SLL;
                    {7'b0000000, 3'b101}: ALUCtrl_o = ALU_SRL;
                    {7'b0100000, 3'b101}: ALUCtrl_o = ALU_SRA;
                    default:             ALUCtrl_o = ALU_ADD;
                endcase
            end
            2'b11: begin // I-type
                case (funct3_i)
                    3'b000: ALUCtrl_o = ALU_ADD; // addi
                    3'b100: ALUCtrl_o = ALU_XOR; // xori
                    3'b110: ALUCtrl_o = ALU_OR;  // ori
                    3'b111: ALUCtrl_o = ALU_AND; // andi
                    3'b001: ALUCtrl_o = ALU_SLL; // slli
                    3'b101: ALUCtrl_o = (funct7_i[5]) ? ALU_SRA : ALU_SRL; // srai / srli
                    default: ALUCtrl_o = ALU_ADD;
                endcase
            end
            default: ALUCtrl_o = ALU_ADD;
        endcase
    end

    endmodule
