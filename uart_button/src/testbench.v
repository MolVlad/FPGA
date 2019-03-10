`timescale 1 ns / 100 ps

module testbench();

reg clk = 1'b0;

always begin
    #1 clk = ~clk;
end

reg button;

wire button_state;

button_bounce button_bounce(.clk(clk), .button(button), .state(button_state));

wire button_edge;

posedge_impulse posedge_impulse(.clk(clk), .in(button_state), .out(button_edge));

initial begin
  button = 0;
  #1000 button = 1;
  #1000 button = 0;
  #100 button = 1;
  #100 button = 0;
  #100 button = 1;
  #100 button = 0;
  #100 button = 1;
  #100 button = 0;
  #100 button = 1;
  #100 button = 0;
  #100 button = 1;
  #100 button = 0;
  #100 button = 1;
  #100 button = 0;
  #100 button = 1;
end

initial begin
	$dumpvars;      /* Open for dump of signals */
	#300000 $finish;
end

endmodule
