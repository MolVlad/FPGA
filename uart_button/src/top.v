module top(
    input CLK,
    input S2,

    output RXD,
    output DS_C,
    output DS_EN1, DS_EN2, DS_EN3, DS_EN4
);

assign {DS_EN1, DS_EN2, DS_EN3, DS_EN4} = 4'b1111;

button_bounce button_bounce(.clk(CLK), .button(S2), .state(button_state));

assign DS_C = button_state;

reg [7:0]data = 8'h61;

uart_out uart_out(.clk(CLK), .data(data), .out(RXD), .flag_start(~button_state));

endmodule



