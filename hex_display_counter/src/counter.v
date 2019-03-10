module counter(
	input clk,

	output [15:0]data
);

reg [15:0]cnt = 15'h0;

always @(posedge clk) begin
	cnt <= cnt + 15'h1;
end

assign data = cnt;

endmodule
