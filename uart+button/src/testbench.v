`timescale 1 ns / 100 ps

module testbench();

reg clk = 1'b0;

always begin
    #1 clk = ~clk;
end

clk_div #(.x(6)) clk_div(.clk(clk), .clk_out(divided_clk));

reg button;

wire button_state;

button_bounce button_bounce(.clk(divided_clk), .button(button), .state(button_state));

initial begin
	$dumpvars;      /* Open for dump of signals */
	#300000 $finish;
end

endmodule
