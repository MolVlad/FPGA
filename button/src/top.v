module top(
    input CLK,
	 input S3,

    output DS_C,
	 output DS_EN1, DS_EN2, DS_EN3, DS_EN4
);

assign {DS_EN1, DS_EN2, DS_EN3, DS_EN4} = 4'b1111;

assign DS_C = S3;

endmodule



