module uart_out (
	input clk,
	input [7:0]data,
	input flag_start,

	output reg out,
	output reg flag_busy
);

wire [9:0]res = {1'b1, data, 1'b0};

reg [3:0]bit_num = 4'h0;

always @(posedge clk) begin
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
