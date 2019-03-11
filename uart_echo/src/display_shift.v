module display_shift(
  input clk,
  input [3:0]num,

  output reg [15:0]data
);

always @(posedge clk) begin
	data[15:4] <= data[11:0];
	data[3:0] <= num;
end


endmodule