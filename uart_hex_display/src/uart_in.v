module uart_in (
	input clk,
	input in,

	output reg [7:0]data,
	output flag_complete
);

reg [3:0]bit_num = 0;
initial data = 8'h0;

always @(posedge clk) begin
	if((in == 0) && (bit_num == 9))
	begin
		bit_num <= 0;
		data <= 0;
	end

	else if(bit_num != 9)
	begin
		bit_num <= bit_num + 1;
		data[bit_num - 2] <= in;
	end
end

assign flag_complete = (bit_num == 9);

endmodule
