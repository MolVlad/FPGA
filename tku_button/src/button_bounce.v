module button_bounce(
	input clk,
	input button,

	output reg state
);

wire divided_clk;

clk_div #(.x(16)) clk_div(.clk(clk), .clk_out(divided_clk));

reg [7:0]sample = 8'h0;

always @(posedge divided_clk) begin
	sample[7:1] <= sample[6:0];
	sample[0] <= button;

	state <= state?  |sample : &sample;
end

endmodule
