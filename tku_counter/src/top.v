module top(
    input CLK,
	 input S1, // ce
	 input S2, // clr
	 input S3, // up
	 input S4,

    output DS_EN1, DS_EN2, DS_EN3, DS_EN4,
    output DS_A, DS_B, DS_C, DS_D, DS_E, DS_F, DS_G, DS_DP
);

reg [25:0]cnt = 0;

always @(posedge CLK) begin
	if (~S4)
		cnt <= (cnt == 9000) ? 0 : cnt + 1;
	else
		cnt <= (cnt == 48000000) ? 0 : cnt + 1;
end

wire counter_clk = (cnt == 0);

wire [15:0]data;

reg L = 0;

reg [3:0]di = 4'hA;
counter counter(.clk(counter_clk), .ce(S1), .clr(~S2), .up(~S3), .L(L), .di(di), .data(data));

wire [3:0]anodes;
assign {DS_EN1, DS_EN2, DS_EN3, DS_EN4} = ~anodes;

wire [7:0]seg;
assign {DS_A, DS_B, DS_C, DS_D, DS_E, DS_F, DS_G, DS_DP} = seg;

hex_display hex_display(.clk(CLK), .data(data), .anodes(anodes), .seg(seg));

endmodule
