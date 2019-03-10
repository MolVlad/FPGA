`timescale 1 ns / 100 ps

module testbench();

reg clk = 1'b0;

always begin
    #1 clk = ~clk;
end

wire bounce_protect_clk;

custome_clk_div #(.x(18), .y(1250)) custome_clk_div(.clk(clk), .clk_out(uart_clk));

wire uart_clk;

reg TXD;

wire [7:0]uart_data;
wire flag_complete;

uart_in uart_in(.clk(uart_clk), .in(TXD), .data(uart_data[7:0]), .flag_complete(flag_complete));

reg [15:0]data = 16'hAA00;

always @(posedge flag_complete) begin
	data[7:0] <= uart_data;
end

wire [3:0]anodes;

wire [7:0]seg;

hex_display hex_display(.clk(clk), .data(data), .anodes(anodes), .seg(seg));

wire button_state;

reg S2;

button_bounce button_bounce(.clk(clk), .button(S2), .state(button_state));

wire button_edge;

posedge_impulse posedge_impulse(.clk(uart_clk), .in(~button_state), .out(button_edge));

wire RXD;

uart_queue uart_queue(.clk(uart_clk), .data(data), .flag_start(button_edge), .out(RXD));

initial begin
  S2 = 0;
  #100 S2 = 1;
  #100 S2 = 0;
  #100 S2 = 1;
  #100 S2 = 0;
  #100 S2 = 1;
  #100 S2 = 0;
  #100 S2 = 1;
  #100 S2 = 0;
  #100 S2 = 1;
  #100 S2 = 0;
  #100 S2 = 1;
  #100 S2 = 0;
end

initial begin
	$dumpvars;      /* Open for dump of signals */
	#300000 $finish;
end

endmodule
