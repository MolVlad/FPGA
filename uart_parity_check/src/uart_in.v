module uart_in (
	input clk,
	input in,

	output reg [7:0]data,
	output flag_complete,
	output reg parity_error
);

reg [3:0]bit_num = 9;

wire parity_bit;

parity_check parity_check(.data(data), .parity_bit(parity_bit));

always @(posedge clk) begin
	if((in == 0) && (bit_num == 9)) begin
		bit_num <= 0;
		data <= 0;
	end

	if(bit_num != 9) begin
		bit_num <= bit_num + 1;
		data[bit_num] <= in;
	end

  if(bit_num == 8)
    parity_error <= ~(parity_bit == in);
end

assign flag_complete = (bit_num == 8);



endmodule
