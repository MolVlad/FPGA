`include "const.v"

module my_block (
    input clk,
    input ce_wr_dat,
    input [7:0] rx_dat,
    input [7:0] com,
    input [15:0] wr_adr,
    input [15:0] rd_adr,
    input [7:0] SW,
	 
	 output reg [15:0] DISPL = 16'h0000,
	 output reg [7:0] LED = 8'h00,
	 output wire [7:0] my_dat);

assign ew0 = wr_adr == `MY_ADR;
assign ew1 = wr_adr == `MY_ADR + 1;
assign ew2 = wr_adr == `MY_ADR + 2;

assign ce_wr_REG = (com == 8'h00) ? ce_wr_dat : 0;

assign er0 = rd_adr == `MY_ADR;
assign er1 = rd_adr == `MY_ADR + 1;
assign er2 = rd_adr == `MY_ADR + 2;
assign er3 = rd_adr == `MY_ADR + 3;

assign rd_my_MEM = (`MY_ADR <= rd_adr) & (rd_adr <= `MY_ADR+255);
assign wr_my_MEM = (`MY_ADR <= wr_adr) & (wr_adr <= `MY_ADR+255);
assign ce_wr_MEM = ((com == 8'h01) & wr_my_MEM) ? ce_wr_dat : 0;
assign my_dat = (com == 8'h80) ? dat_REG : ((com == 8'h81) & rd_my_MEM) ? dat_MEM : 8'h0;

wire [7:0] dat_MEM;
reg [7:0] dat_REG;

BMEM_256x8 mem(.clk(clk), .we(ce_wr_MEM), .DI(rx_dat), .Adr_wr(wr_adr[7:0]), .Adr_rd(rd_adr[7:0]),
    .DO(dat_MEM));

always @ (posedge clk) begin
    LED <= (ce_wr_REG & ew0) ? rx_dat : LED;
    DISPL[15:8] <= (ce_wr_REG & ew1) ? rx_dat : DISPL[15:8];
    DISPL[7:0] <= (ce_wr_REG & ew2) ? rx_dat : DISPL[7:0];
    dat_REG <= er0 ? LED : er1 ? DISPL[15:8] : er2 ? DISPL[7:0] : er3 ? SW : 8'h0;
end

endmodule


module BMEM_256x8 (
    input clk,      output reg [7:0]DO,
    input we,
    input [7:0] DI,
    input [7:0] Adr_wr,
    input [7:0] Adr_rd);

reg [7:0] MEM [255:0]; //блочная память 8 x 256 bit.

always @ (posedge clk) begin
    MEM[Adr_wr]<= we? DI :MEM[Adr_wr]; //Запись в память
    DO <= MEM[Adr_rd];
end

endmodule
