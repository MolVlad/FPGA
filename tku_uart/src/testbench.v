`timescale 1 ns / 100 ps

module testbench();

reg clk = 1'b0;

always begin
    #10 clk = ~clk; /* Toggle clock every 10ns <=> 50MHz clock rate */
end

/* --- OUTPUT --- */
wire [15:0] DISPL;
wire [7:0] LED;
wire [7:0] my_dat;

/* --- INPUT --- */
reg ce_wr_dat = 0;
reg [7:0] rx_dat = 8'h00;
reg [7:0] rx_com = 8'h00;
reg [15:0] wr_adr = 16'h0000;
reg [15:0] rd_adr = 16'h0000;
reg [7:0] SW = 8'h00;

my_block my_block(.clk(clk), .ce_wr_dat(ce_wr_dat), .rx_dat(rx_dat), .com(rx_com), .wr_adr(wr_adr), .rd_adr(rd_adr), .SW(SW),
	.DISPL(DISPL), .LED(LED), .my_dat(my_dat));

// MY_ADR = 16'h4900
initial begin
    /* --- Writing test --- */
    #100
    ce_wr_dat = 1; rx_dat = 8'h11; rx_com = 8'h00; wr_adr = 16'h4900; // 11 => LED
    #100
    ce_wr_dat = 0;
    #100
    ce_wr_dat = 1; rx_dat = 8'h22; rx_com = 8'h00; wr_adr = 16'h4901; // 22 => DISPL[15:8]
    #100
    ce_wr_dat = 0;
    #100
    ce_wr_dat = 1; rx_dat = 8'h33; rx_com = 8'h00; wr_adr = 16'h4902; // 33 => DISPL[7:0]
    #100
    ce_wr_dat = 0;
    #100
    ce_wr_dat = 1; rx_dat = 8'hAA; rx_com = 8'h01; wr_adr = 16'h4900; // AA => MEM[00]
    #100
    ce_wr_dat = 0;
    #100
    ce_wr_dat = 1; rx_dat = 8'h44; rx_com = 8'h01; wr_adr = 16'h4903; // 44 => MEM[03]
    #100
    ce_wr_dat = 0;
    #100
    ce_wr_dat = 1; rx_dat = 8'h55; rx_com = 8'h01; wr_adr = 16'h4904; // 55 => MEM[04]
    #100
    ce_wr_dat = 0; rx_dat = 8'h00; wr_adr = 16'h0000;

    /* --- Reading test --- */
    #100
    rx_com = 8'h80; rd_adr = 16'h4900; // Read LED
    #100
    rx_com = 8'h80; rd_adr = 16'h4901; // Read DISPL[15:8]
    #100
    rx_com = 8'h80; rd_adr = 16'h4902; // Read DISPL[7:0]
    #100
    rx_com = 8'h80; rd_adr = 16'h4903; // Read SW
    #50
    SW = 16'hFF;
    #50
    rx_com = 8'h80; rd_adr = 16'h4903; // Read SW
    #100
    rx_com = 8'h81; rd_adr = 16'h4900; // Read MEM[00]
    #100
    rx_com = 8'h81; rd_adr = 16'h4901; // Read MEM[01]
    #100
    rx_com = 8'h81; rd_adr = 16'h4902; // Read MEM[02]
    #100
    rx_com = 8'h81; rd_adr = 16'h4903; // Read MEM[03]
    #100
    rx_com = 8'h81; rd_adr = 16'h4904; // Read MEM[04]
    #100
    rx_com = 8'h81; rd_adr = 16'h4905; // Read MEM[05]
end

initial begin
	$dumpvars;      /* Open for dump of signals */
	#300000
    //#20000000
    $finish;
end

endmodule

/*
com=8’h00 – загрузить байт в регистр,
com=8’h80 – прочитать регистр,
com=8’h01 – загрузить байт в память,
com=8’h81 – прочитать память.
*/
