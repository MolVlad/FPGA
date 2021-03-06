module top(
    input CLK,
	 input S1 // st
);

reg [`m-1:0] MTX_DAT = `m'b101111010;
wire [`m-1:0] MRX_DAT;

reg [`m-1:0] STX_DAT = `m'b111011011;
wire [`m-1:0] SRX_DAT;

SPI_MASTER master(
    .clk(CLK),
    .st(S1),
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

endmodule
