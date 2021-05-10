`timescale 1 ns / 100 ps

module testbench();

reg clk = 1'b0;
reg [1:0] Nvel;
reg [7:0] ADR;
reg [22:0] DAT;
reg st = 0;

AR_TXD txd(
    .clk(clk),
    .Nvel(Nvel),
    .ADR(ADR),
    .DAT(DAT),
    .st(st),

    .TXD0(TXD0),
    .TXD1(TXD1)
);

AR_RXD rxd(
    .clk(clk),
    .Nvel(Nvel),
    .Inp0(TXD0),
    .Inp1(TXD1)
);

always begin
    #1 clk = ~clk; /* Toggle clock every 1ns */
end

initial begin
    st = 0; Nvel = 0; ADR = 0; DAT = 0;
    #1004; st = 1; Nvel = 3; ADR = 8'h84; DAT = 23'h112200;
    #20; st = 0;
    #5004; st = 1; Nvel = 3; ADR = 8'h84; DAT = 23'h112200;
    #20; st = 0;
end

initial begin
    $dumpvars;      /* Open for dump of signals */
    $display("Test started...");
    #15000 $finish;
end

endmodule



