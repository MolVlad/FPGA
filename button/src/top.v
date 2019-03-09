module top(
    input CLK,
	 input S2,

    output DS_C,
	 output DS_EN1, DS_EN2, DS_EN3, DS_EN4
);

assign {DS_EN1, DS_EN2, DS_EN3, DS_EN4} = 4'b1111;

clk_div #(.x(6)) clk_div(.clk(clk), .clk_out(divided_clk));

button_bounce button_bounce(.clk(divided_clk), .button(S2), .state(button_state));

assign DS_C = button_state;
//assign DS_C = S2;

endmodule



