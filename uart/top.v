module top(
	input CLK,

	output RXD,
	input TXD
);


wire uart_clk;
reg [7:0]data = 8'b1000011;	//8'h61;	// A

clk_div #(.x(15), .y(5000)) clk_div(.clk(CLK), .clk_out(uart_clk));
uart_out uart_out(.clk(uart_clk), .out(RXD), .data(data));
//uart_in uart_in(.clk(uart_clk), .in(TXD), .data(data));

endmodule
