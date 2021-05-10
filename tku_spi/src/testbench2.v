`timescale 1 ns / 100 ps
`include "const.v"

module testbench();

reg clk = 1'b0;
reg st = 1'b0;

reg [`m-1:0] MTX_DAT = `m'b101111010;
wire [`m-1:0] MRX_DAT;

reg [`m-1:0] STX_DAT = `m'b111011011;
wire [`m-1:0] SRX_DAT;

SPI_MASTER master(
    .clk(clk),
    .st(st),
    .MTX_DAT(MTX_DAT),
    .MISO(MISO),

    .MOSI(MOSI),
    .SCLK(SCLK),
    .LOAD(LOAD),
    .MRX_DAT(MRX_DAT)
);

SPI_SLAVE slave(
    .MOSI(MOSI),
    .LOAD(LOAD),
    .SCLK(SCLK),
    .STX_DAT(STX_DAT),

    .MISO(MISO),
    .SRX_DAT(SRX_DAT)
);

always begin
    #1 clk = ~clk; /* Toggle clock every 1ns */
end

initial begin
    st = 0;
    #40 st = 1;
    #3 st = 0;
    #3001 st = 1;
    #5 st = 0;
end

initial begin
    $dumpvars;      /* Open for dump of signals */
    $display("Test started...");
    #7000 $finish;
end

endmodule



