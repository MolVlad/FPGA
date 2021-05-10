module top(
    input CLK,
	 input S1, // ce
	 input S2, // clr
	 input S3, // up
	 input S4, // clk

    output DS_EN1, DS_EN2, DS_EN3, DS_EN4,
    output DS_A, DS_B, DS_C, DS_D, DS_E, DS_F, DS_G, DS_DP
);

button_bounce button_bounce(.clk(CLK), .button(~S4), .state(button_state));

wire [15:0]data;

reg L = 0;

reg [3:0]di = 4'hA;
counter counter(.clk(button_state), .ce(S1), .clr(~S2), .up(~S3), .L(L), .di(di), .data(data));

wire [3:0]anodes;
assign {DS_EN1, DS_EN2, DS_EN3, DS_EN4} = ~anodes;

wire [7:0]seg;
assign {DS_A, DS_B, DS_C, DS_D, DS_E, DS_F, DS_G, DS_DP} = seg;

hex_display hex_display(.clk(CLK), .data(data), .anodes(anodes), .seg(seg));

endmodule
