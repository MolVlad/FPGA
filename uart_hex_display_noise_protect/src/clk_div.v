module clk_div #(parameter x = 2, parameter y = 1)(
	input clk,

	output clk_out
);

reg [x-1:0]cnt = 0;
	
always @(posedge clk) begin
	if(cnt == y)
		cnt <= 0;
	else
		cnt <= cnt + 1;
end

assign clk_out = (cnt == 0);

endmodule
