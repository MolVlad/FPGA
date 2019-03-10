module top(
    input CLK,
    input TXD,
	 input S2,
	 
	 output RXD,
    output DS_EN1, DS_EN2, DS_EN3, DS_EN4,
    output DS_A, DS_B, DS_C, DS_D, DS_E, DS_F, DS_G, DS_DP
);

wire uart_clk;

custome_clk_div #(.x(18), .y(1250)) custome_clk_div(.clk(CLK), .clk_out(uart_clk));	// 1250 * 38400 = 48.000.000

wire [7:0]uart_data;
wire flag_complete;

uart_in uart_in(.clk(uart_clk), .in(TXD), .data(uart_data), .flag_complete(flag_complete));

wire [15:0]data;

wire [3:0]hex_data;

ascii_to_hex ascii_to_hex(.ascii(uart_data), .hex(hex_data));

display_shift display_shift(.clk(flag_complete), .num(hex_data), .data(data));

wire [3:0]anodes;
assign {DS_EN1, DS_EN2, DS_EN3, DS_EN4} = ~anodes;

wire [7:0]seg;
assign {DS_A, DS_B, DS_C, DS_D, DS_E, DS_F, DS_G, DS_DP} = seg;

hex_display hex_display(.clk(CLK), .data(data), .anodes(anodes), .seg(seg));

wire button_state;

button_bounce button_bounce(.clk(CLK), .button(S2), .state(button_state));

wire button_edge;

posedge_impulse posedge_impulse(.clk(uart_clk), .in(~button_state), .out(button_edge));

uart_queue uart_queue(.clk(uart_clk), .data(data), .flag_start(button_edge), .out(RXD));

endmodule
