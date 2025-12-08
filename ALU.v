module ALU
( // Do not modify port names
    input      [63:0] data1_i,
    input      [63:0] data2_i,
    input      [3:0]  ALUCtrl_i,
    output reg [63:0] data_o
);

localparam ALU_ADD = 4'b0000;
localparam ALU_SUB = 4'b0001;
localparam ALU_AND = 4'b0010;
localparam ALU_OR  = 4'b0011;
localparam ALU_XOR = 4'b0100;
localparam ALU_SLL = 4'b0101;
localparam ALU_SRL = 4'b0110;
localparam ALU_SRA = 4'b0111;

wire [5:0] shamt = data2_i[5:0];

always @(*) begin
    case (ALUCtrl_i)
        ALU_ADD: data_o = data1_i + data2_i;
        ALU_SUB: data_o = data1_i - data2_i;
        ALU_AND: data_o = data1_i & data2_i;
        ALU_OR : data_o = data1_i | data2_i;
        ALU_XOR: data_o = data1_i ^ data2_i;
        ALU_SLL: data_o = data1_i << shamt;
        ALU_SRL: data_o = data1_i >> shamt;
        ALU_SRA: data_o = $signed(data1_i) >>> shamt;
        default: data_o = 64'd0;
    endcase
end

endmodule
