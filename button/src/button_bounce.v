module button_bounce(
	input clk,
	input button,

	output state
);

reg [7:0]sample = 8'h0;

always @(posedge clk) begin
	sample <= (sample << 1);
	
	sample[0] <= button;
end

assign state = (sample == 8'b11111111);

endmodule
