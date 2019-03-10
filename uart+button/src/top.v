module top(
    input CLK,
	 input S2,

    output DS_C,
	 output DS_EN1, DS_EN2, DS_EN3, DS_EN4
);

assign {DS_EN1, DS_EN2, DS_EN3, DS_EN4} = 4'b1111;

button_bounce button_bounce(.clk(CLK), .button(S2), .state(button_state));

assign DS_C = button_state;

endmodule



