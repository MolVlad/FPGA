module top(
    input CLK,
    input S2,

    output RXD,
    output DS_C,
    output DS_EN1, DS_EN2, DS_EN3, DS_EN4
);

assign {DS_EN1, DS_EN2, DS_EN3, DS_EN4} = 4'b1111;

clk_div #(.x(16), .y(5000)) clk_div(.clk(CLK), .clk_out(uart_clk));

button_bounce button_bounce(.clk(CLK), .button(S2), .state(button_state));

assign DS_C = button_state;

wire button_edge;

posedge_impulse posedge_impulse(.clk(uart_clk), .in(~button_state), .out(button_edge));

reg [7:0]data = 8'h61;

uart_out uart_out(.clk(uart_clk), .data(data), .out(RXD), .flag_start(button_edge));
endmodule
