`timescale 1 ns / 100 ps

module testbench();

reg clk = 1'b0;

always begin
    #1 clk = ~clk;
end

initial begin
	$dumpvars;      /* Open for dump of signals */
	#300000 $finish;
end

endmodule
