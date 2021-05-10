module top(
	input CLK,
	input S1, // st
	input S2, // SW[0]
	input S3, // SW[1]
	input S4, // R

	output DS_EN1, DS_EN2, DS_EN3, DS_EN4,
	output DS_A, DS_B, DS_C, DS_D, DS_E, DS_F, DS_G, DS_DP
);

wire [15:0] DATA;
wire [7:0] sr_adr;
wire [22:0] sr_dat;

reg [7:0] RX_ADR = 0;
reg [22:0] RX_DAT = 0;

reg [7:0] TX_ADR = 8'h84;
reg [22:0] TX_DAT = 23'h112200;
reg TX_OK = 1'b1;
reg [1:0] Nvel = 2'h3;

AR_TXD txd(
    .clk(CLK),
    .Nvel(Nvel),
    .ADR(TX_ADR),
    .DAT(TX_DAT),
    .st(S1),

    .TXD0(TXD0),
    .TXD1(TXD1)
);

AR_RXD rxd(
    .clk(CLK),
    .Nvel(Nvel),
    .Inp0(TXD0),
    .Inp1(TXD1),

    .sr_adr(sr_adr),
    .sr_dat(sr_dat),
    .ce_wr(RX_OK)
);

AR_MUX mux(
    .TX_ADR(TX_ADR),
    .TX_DAT(TX_DAT),
    .TX_OK(TX_OK),
    .RX_ADR(RX_ADR),
    .RX_DAT(RX_DAT),
    .RX_OK(RX_OR),
	 .SW({S2,S3}),

    .DATA(DATA)
);

always @ (posedge CLK) begin
    RX_ADR <= S4 ? 0 : sr_adr;
    RX_DAT <= S4 ? 0 : sr_dat;
end

wire [3:0]anodes;
assign {DS_EN1, DS_EN2, DS_EN3, DS_EN4} = ~anodes;

wire [7:0]seg;
assign {DS_A, DS_B, DS_C, DS_D, DS_E, DS_F, DS_G, DS_DP} = seg;

hex_display hex_display(.clk(CLK), .data(DATA), .anodes(anodes), .seg(seg));

endmodule


module AR_MUX(
    input [7:0] TX_ADR,
    input [22:0] TX_DAT,
    input TX_OK,
    input [7:0] RX_ADR,
    input [22:0] RX_DAT,
    input RX_OK,
    input [1:0] SW,

    output [15:0] DATA
);

assign DATA = (SW == 0) ? {TX_DAT[7:0], TX_ADR} :
    (SW == 1) ? {1'b0, TX_DAT[22:8]} :
    (SW == 2) ? {RX_DAT[7:0], RX_ADR[7:0]} :
    {1'b0, RX_DAT[22:8]};

endmodule
