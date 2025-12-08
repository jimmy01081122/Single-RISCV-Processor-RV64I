module PC
(   // Do not modify port names
    input             clk_i,
    input             rst_i,
    input      [63:0] pc_i,
    output reg [63:0] pc_o
);

// PC should be reset to 0 when rst_i is high.
// Update PC on the rising edge of the clock.
always @(posedge clk_i or posedge rst_i) begin
    if (rst_i)
        pc_o <= 64'd0;
    else
        pc_o <= pc_i;
end

endmodule
