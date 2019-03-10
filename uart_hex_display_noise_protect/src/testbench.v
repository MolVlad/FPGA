`timescale 1 ns / 100 ps

module testbench();

reg clk = 1'b0;

always begin
    #1 clk = ~clk;
end

wire bounce_protect_clk;

clk_div #(.x(18), .y(625)) clk_div(.clk(clk), .clk_out(bounce_protect_clk));	// 625 * 8 = 5000; 5000 * 9600 = 48.000.000

wire value;
wire uart_clk;

reg TXD;

bounce_protect bounce_protect(.clk(bounce_protect_clk), .in(TXD), .out(value), .clk_out(uart_clk));

wire [7:0]uart_data;
wire flag_complete;

uart_in uart_in(.clk(uart_clk), .in(value), .data(uart_data[7:0]), .flag_complete(flag_complete));

reg [15:0]data = 16'hAA00;

always @(posedge flag_complete) begin
	data[7:0] <= uart_data;
end

wire [3:0]anodes;

wire [7:0]seg;

hex_display hex_display(.clk(clk), .data(data), .anodes(anodes), .seg(seg));

initial begin
	TXD = 0;

	#5000 TXD = 1;
	#5000 TXD = 0;
	#5000 TXD = 1;
	#5000 TXD = 0;
	#5000 TXD = 1;
	#5000 TXD = 0;
	#5000 TXD = 1;
	#5000 TXD = 0;

	#5000 TXD = 1;
end

initial begin
	$dumpvars;      /* Open for dump of signals */
	#300000 $finish;
end

endmodule
