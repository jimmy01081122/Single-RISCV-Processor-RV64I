module CPU
(
    input clk_i, 
    input rst_i
);

wire [63:0] pc_o;
wire [63:0] pc_i;
wire [31:0] instr;
wire [4:0] rs1_addr;
wire [4:0] rs2_addr;
wire [4:0] rd_addr;
wire [63:0] rs1_data;
wire [63:0] rs2_data;
wire [63:0] imm_data;
wire [63:0] alu_in2;
wire [63:0] alu_result;
wire        RegWrite;
wire        ALUSrc;
wire [1:0]  ALUOp;
wire [3:0]  ALUCtrl;

assign rs1_addr = instr[19:15];
assign rs2_addr = instr[24:20];
assign rd_addr  = instr[11:7];
assign alu_in2  = ALUSrc ? imm_data : rs2_data;
assign pc_i     = pc_o + 64'd4;

// Do not change the name of these module instances.
Instruction_Memory Instruction_Memory(
    .addr_i     (pc_o), 
    .instr_o    (instr)
);

PC PC(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .pc_i       (pc_i),
    .pc_o       (pc_o)
);

Registers Registers(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .RS1addr_i  (rs1_addr),
    .RS2addr_i  (rs2_addr),
    .RDaddr_i   (rd_addr), 
    .RDdata_i   (alu_result),
    .RegWrite_i (RegWrite), 
    .RS1data_o  (rs1_data), 
    .RS2data_o  (rs2_data) 
);

Control Control(
    .op_i       (instr[6:0]),
    .ALUSrc_o   (ALUSrc),
    .RegWrite_o (RegWrite),
    .ALUOp_o    (ALUOp)
);

Imm_Gen Imm_Gen(
    .instr_i    (instr),
    .Imm_o      (imm_data)
);

ALU_Control ALU_Control(
    .funct7_i   (instr[31:25]),
    .funct3_i   (instr[14:12]),
    .ALUOp_i    (ALUOp),
    .ALUCtrl_o  (ALUCtrl)
);

ALU ALU(
    .data1_i    (rs1_data),
    .data2_i    (alu_in2),
    .ALUCtrl_i  (ALUCtrl),
    .data_o     (alu_result)
);


endmodule
