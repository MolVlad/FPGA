module uart_out (
	input clk,
	input [7:0]data,
	input flag_start,

	output reg out,
	output reg flag_busy
);

reg [13:0]cnt;

always @(posedge clk) begin
	if(cnt == 5000)		//48.000.000 / 5000 = 9600
		cnt <= 1'b0;
	else
		cnt <= cnt + 1'b1;
end

assign divided_clk = (cnt == 1'b0);

wire [9:0]res = {1'b1, data, 1'b0};

reg [3:0]bit_num = 4'h0;

always @(posedge divided_clk) begin
	out <= res[bit_num];
	
	if((flag_start == 1) && (flag_busy == 0)) begin
		bit_num <= 0;
		flag_busy <= 1;
	end

	if((bit_num == 9) && (flag_busy == 1))
		flag_busy <= 0;
	else if(flag_busy == 1)
		bit_num <= bit_num + 1;
end

endmodule
