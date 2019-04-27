`timescale 1 ns / 100 ps

module testbench;

reg clk = 1'b0;

always begin
    #1 clk = ~clk;
end

wire [15:0]data;

cpu_top cpu_top(
    .clk(clk),
    .data_out(data)
);

initial begin
    $dumpvars;
    #60 $finish;
end

endmodule
