module cpu_top #(parameter ADDR_WIDTH = 4)(
    input clk
);

wire [31:0]instr_addr;
wire [31:0]instr_data;
rom #(.ADDR_WIDTH(ADDR_WIDTH))rom(.clk(clk), .addr(instr_addr[ADDR_WIDTH - 1:0]), .q(instr_data));

core core(
    .clk(clk),
    .instr_data(instr_data), .last_pc(16),
    .instr_addr(instr_addr)
);

endmodule
