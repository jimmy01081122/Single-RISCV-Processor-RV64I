module Registers
( // Do not modify port names
    input         clk_i,
    input         rst_i,
    input  [4:0]  RS1addr_i,
    input  [4:0]  RS2addr_i,
    input  [4:0]  RDaddr_i,
    input  [63:0] RDdata_i,
    input         RegWrite_i,
    output [63:0] RS1data_o, 
    output [63:0] RS2data_o
);

// Store the content of registers here.
// Do not change the name.
reg signed [63:0] register [0:31];

// All registers should be reset to 0 when rst_i is high.
// Make sure that register[0] is always 0.
integer i;

always @(posedge clk_i or posedge rst_i) begin
    if (rst_i) begin
        for (i = 0; i < 32; i = i + 1)
            register[i] <= 64'd0;
    end else begin
        register[0] <= 64'd0;
        if (RegWrite_i && RDaddr_i != 0)
            register[RDaddr_i] <= RDdata_i;
    end
end

assign RS1data_o = (RS1addr_i == 0) ? 64'd0 : register[RS1addr_i];
assign RS2data_o = (RS2addr_i == 0) ? 64'd0 : register[RS2addr_i];

endmodule 
