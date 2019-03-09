module top(
    input CLK,
	 input S1,

    output DS_A, DS_B, DS_C, DS_D,
	 output DS_EN1, DS_EN2, DS_EN3, DS_EN4
);

assign {DS_EN1, DS_EN2, DS_EN3, DS_EN4} = 4'b1111;

assign DS_A = S1;

endmodule



