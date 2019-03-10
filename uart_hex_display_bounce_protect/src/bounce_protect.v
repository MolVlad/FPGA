module bounce_protect(
	input clk,
	input in,

	output out,
	output clk_out
);

reg [7:0]sample = 8'h0;
reg [2:0]i = 0;

always @(posedge clk) begin
	sample[i] <= in;
		
	i <= i + 1;
end

assign clk_out = i[2];

wire [2:0]result;
assign result = (8'h0 + sample[0] + sample[1] + sample[2] + sample[3] + sample[4]);

assign out = (result > 2);

endmodule
