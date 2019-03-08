`timescale 1 ns / 100 ps

module testbench();

reg clk = 1'b0;

always begin
    #1 clk = ~clk;
end

wire clk_out;
clk_div #(.x(15), .y(5000)) clk_div(.clk(clk), .clk_out(clk_out));

wire out;
reg [7:0]data_out = 8'h61;
uart_out uart_out(.clk(clk_out), .out(out), .data(data_out));

wire in = out;
wire [7:0]data_in = 8'h0;
uart_in uart_in(.clk(clk_out), .in(in), .data(data_in));

initial begin
	$dumpvars;      /* Open for dump of signals */
	#500000 $finish;
end

endmodule
