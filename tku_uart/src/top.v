module top(
    input CLK,
	 input TXD,

	 output RXD,
    output DS_EN1, DS_EN2, DS_EN3, DS_EN4,
    output DS_A, DS_B, DS_C, DS_D, DS_E, DS_F, DS_G, DS_DP,
	 output SDRAM_A0
);

wire [15:0] DISPL;
wire [7:0] LED;
wire [7:0] my_dat;
wire [7:0] rx_dat;
wire [15:0] wr_adr;
wire [15:0] rd_adr;
reg [7:0] SW = 8'hFF;
wire [7:0] rx_com;
wire [7:0] rx_lbl;

my_block my_block(.clk(CLK), .ce_wr_dat(ce_wr_dat), .rx_dat(rx_dat), .com(rx_com), .wr_adr(wr_adr), .rd_adr(rd_adr), .SW(SW),
	.DISPL(DISPL), .LED(LED), .my_dat(my_dat));

RET_TXD_CRC_BL RET_TXD_CRC_BL(.st(ok_rx_bl), .clk(CLK), .com(rx_com), .lbl(rx_lbl), .adr(wr_adr), .dat(my_dat),
	.rd_adr(rd_adr), .en_tx(), .tx_dat(), .CRC(), .cb_byte(), .UTXD(RXD));
	 
URXD_CRC_BL URXD_CRC_BL(.URXD(TXD), .clk(CLK), .en_rx_byte(), .en_rx_bl(), .ok_rx_byte(), .cb_byte(), .res(), .rx_lbl(rx_lbl), .CRC(),
	.ce_wr_dat(ce_wr_dat), .rx_dat(rx_dat), .com(rx_com), .wr_adr(wr_adr), .ok_rx_bl(ok_rx_bl), .ce_bit(SDRAM_A0));

wire [3:0]anodes;
assign {DS_EN1, DS_EN2, DS_EN3, DS_EN4} = ~anodes;

wire [7:0]seg;
assign {DS_A, DS_B, DS_C, DS_D, DS_E, DS_F, DS_G, DS_DP} = seg;

hex_display hex_display(.clk(CLK), .data(DISPL), .anodes(anodes), .seg(seg));

endmodule
