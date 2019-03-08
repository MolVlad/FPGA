module uart_out (
	input clk,
	input [7:0]data,

	output out
);

wire start = 1'b0;
wire stop = 1'b1;
wire [9:0]res = {stop, data, start};

reg [3:0]bit_num = 0;
reg bit = 1'b1;

always @(posedge clk) begin	
	bit <= res[bit_num];

	if(bit_num == 9)
		bit_num <= 0;
	else
		bit_num <= bit_num + 1;
end

assign out = bit;

endmodule
