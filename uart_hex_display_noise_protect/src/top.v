module top(
    input CLK,
    input TXD,

    output DS_EN1, DS_EN2, DS_EN3, DS_EN4,
    output DS_A, DS_B, DS_C, DS_D, DS_E, DS_F, DS_G, DS_DP
);

wire bounce_protect_clk;

clk_div #(.x(18), .y(625)) clk_div(.clk(CLK), .clk_out(bounce_protect_clk));	// 625 * 8 = 5000; 5000 * 9600 = 48.000.000

wire value;
wire uart_clk;

bounce_protect bounce_protect(.clk(bounce_protect_clk), .in(TXD), .out(value), .clk_out(uart_clk));

wire [7:0]uart_data;
wire flag_complete;

uart_in uart_in(.clk(uart_clk), .in(value), .data(uart_data[7:0]), .flag_complete(flag_complete));

reg [15:0]data = 16'hAA00;

always @(posedge flag_complete) begin
	data[7:0] <= uart_data;
end

wire [3:0]anodes;
assign {DS_EN1, DS_EN2, DS_EN3, DS_EN4} = ~anodes;

wire [7:0]seg;
assign {DS_A, DS_B, DS_C, DS_D, DS_E, DS_F, DS_G, DS_DP} = seg;

hex_display hex_display(.clk(CLK), .data(data), .anodes(anodes), .seg(seg));

endmodule
