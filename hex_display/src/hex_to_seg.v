module hex_to_seg (
	input [3:0]data,

	output reg [7:0]seg
);


always @(*) begin
	case(data)
		4'h0: seg = 8'b11111100;
		4'h1: seg = 8'b01100000;
		4'h2: seg = 8'b11011010;
		4'h3: seg = 8'b11110010;
		4'h4: seg = 8'b01100110;
		4'h5: seg = 8'b10110110;
		4'h6: seg = 8'b10111110;
		4'h7: seg = 8'b11100000;
		4'h8: seg = 8'b11111110;
		4'h9: seg = 8'b11110110;
		4'hA: seg = 8'b11101110;
		4'hB: seg = 8'b00111110;
		4'hC: seg = 8'b10011100;
		4'hD: seg = 8'b01111010;
		4'hE: seg = 8'b10011110;
		4'hF: seg = 8'b10001110;
	endcase
end

endmodule
