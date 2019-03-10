module hex_display (
	input clk,
	input [15:0]data,

	output [3:0]anodes,
	output [7:0]seg
);

reg [1:0]i = 2'h0;
wire [3:0]num = data[i * 4 +: 4];

assign anodes = (4'b1 << i);

hex_to_seg hex_to_seg(.data(num), .seg(seg));

always @(posedge clk) begin
	i <= i + 1'h1;
end

endmodule
