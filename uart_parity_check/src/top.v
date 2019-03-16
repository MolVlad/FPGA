module top(
    input CLK,
    input TXD,
    input S2,

    output RXD,
    output DS_EN1, DS_EN2, DS_EN3, DS_EN4,
    output DS_A, DS_B, DS_C, DS_D, DS_E, DS_F, DS_G, DS_DP
);

/* -------------- Clock ------------------ */

wire uart_clk;

custome_clk_div #(.x(18), .y(1250)) custome_clk_div(.clk(CLK), .clk_out(uart_clk));	// 1250 * 38400 = 48.000.000

/* -------------- UART TX ---------------- */

wire [7:0]uart_data;
wire flag_complete;

uart_in uart_in(.clk(uart_clk), .in(TXD), .data(uart_data), .flag_complete(flag_complete), .parity_error(DS_C));

/* -------------- UART RX ---------------- */

wire uart_in_edge;

posedge_impulse posedge_impulse(.clk(uart_clk), .in(flag_complete), .out(uart_in_edge));

uart_out uart_out(.clk(uart_clk), .data(uart_data), .out(RXD), .flag_start(uart_in_edge));

endmodule
