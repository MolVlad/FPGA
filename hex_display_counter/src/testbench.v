`timescale 1 ns / 100 ps

module testbench();

reg clk = 1'b0;

always begin
    #1 clk = ~clk;
end

reg [25:0]cnt = 0;

always @(posedge CLK) begin
	if(cnt == 48000000)
		cnt <= 0;
	else
		cnt <= cnt + 1;
end

wire counter_clk = (cnt == 0);

wire [15:0]data;
counter counter(.clk(counter_clk), .data(data));

wire [3:0]anodes;

wire [7:0]seg;

hex_display hex_display(.clk(clk), .data(data), .anodes(anodes), .seg(seg));

initial begin
	$dumpvars;      /* Open for dump of signals */
	#300000 $finish;
end

endmodule
