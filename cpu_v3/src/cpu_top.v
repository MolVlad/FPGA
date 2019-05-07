module cpu_top #(parameter ADDR_WIDTH = 5)(
    input clk,

    output [15:0]data_out
);

wire [31:0]instr_addr;
wire [31:0]instr_data;
wire [31:0]mem_addr;
wire [31:0]mem_data;
wire mem_we;

rom #(.ADDR_WIDTH(ADDR_WIDTH))rom(.clk(clk), .addr(instr_addr[ADDR_WIDTH - 1:0]), .q(instr_data));

core core(
    .clk(clk),
    .instr_data(instr_data), .last_pc(1),
    .instr_addr(instr_addr),
    .mem_addr(mem_addr),
    .mem_data(mem_data),
    .mem_we(mem_we)
);

mem_ctrl mem_ctrl(
    .clk(clk),
    .addr(mem_addr),
    .data(mem_data),
    .we(mem_we),

    .data_out(data_out)
);

endmodule
