module core(
    input clk,
    input [31:0]instr_data,
    input [31:0]last_pc,

    output [31:0]instr_addr,
    output [31:0]mem_addr,
    output [31:0]mem_data,
    output mem_we
);

reg [31:0]pc = 32'hFFFFFFFF;
wire [31:0]pc_next = (pc == last_pc) ? pc : pc + 1;

always @(posedge clk) begin
    pc <= pc_next;
    $strobe("CPUv1: [%h] %h", pc, instr);
end

wire [31:0]instr = instr_data;
assign instr_addr = pc_next;

wire [4:0]rs1 = instr[19:15];
wire [4:0]rs2 = instr[24:20];
wire [4:0]rd = instr[11:7];

wire [31:0]alu_res;
wire [4:0]alu_op;
wire [31:0]alu_src_a = rf_rdata0;
wire [31:0]alu_src_b = is_from_rf ? rf_rdata1 : imm32;

wire [11:0]imm12;
wire [31:0]imm32 = {{20{imm12[11]}}, imm12};

alu alu(
    .src_a(alu_src_a), .src_b(alu_src_b),
    .op(alu_op),
    .res(alu_res)
);

wire [31:0]rf_rdata0;
wire [4:0]rf_raddr0 = rs1;

wire [31:0]rf_rdata1;
wire [4:0]rf_raddr1 = rs2;

wire [31:0]rf_wdata = alu_res;
wire [4:0]rf_waddr = rd;
wire rf_we;

assign mem_data = rf_rdata1;
assign mem_addr = alu_res;

reg_file reg_file(
    .clk(clk),
    .raddr0(rf_raddr0), .rdata0(rf_rdata0),
    .raddr1(rf_raddr1), .rdata1(rf_rdata1),
    .waddr(rf_waddr), .wdata(rf_wdata), .we(rf_we)
);

control control(
    .instr(instr_data),
    .imm12(imm12),
    .alu_op(alu_op),
    .rf_we(rf_we),
    .is_from_rf(is_from_rf),
    .mem_we(mem_we)
);

endmodule
