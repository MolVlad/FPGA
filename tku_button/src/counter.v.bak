module counter(
	input clk,
    input ce,
    input clr,
    input up,
    input L,
    input [3:0]di,

	output [15:0]data
);

wire ce1;
VCBD4SE VCBD4SE(.clk(clk), .ce(ce), .s(clr),
    .Q(data[3:0]), .TC(), .CEO(ce1));

wire ce2;
VCB4CLED VCB4CLED(.clk(clk), .ce(ce1), .clr(clr), .up(up), .L(L), .di(di),
    .Q(data[7:4]), .TC(), .CEO(ce2));

wire ce3;
VCD4RE VCD4RE(.clk(clk), .ce(ce2), .r(clr),
    .Q(data[11:8]), .TC(), .CEO(ce3));

VCJ4RE VCJ4RE(.clk(clk), .ce(ce3), .R(clr),
    .Q(data[15:12]), .TC(), .CEO());

endmodule

module VCJ4RE(
    input clk,
    input ce,
    input R,

    output reg[3:0] Q = 0,
    output wire TC,
    output wire CEO);

assign TC = (Q==4'hF) ;
assign CEO = ce & TC ;

always @ (posedge clk) begin
    Q <= R? 0 : ce? Q<<1 | !Q[3] : Q ;
end

endmodule

module VCD4RE(
    input clk,
    input ce,
    input r,
    
    output reg [3:0] Q=0,
    output wire TC,
    output wire CEO
);

assign TC = (Q==9) ;
assign CEO = ce & TC ;
always @ (posedge clk) begin
Q <= (r | CEO)? 0 : ce? Q+1 : Q ;
end
endmodule


module VCB4CLED(
    input clk,
    input ce,
    input clr,
    input up,
    input L,
    input [3:0] di,

    output reg [3:0] Q =0,
    output wire TC,
    output wire CEO
);

assign TC = up? (Q==4'hF) : (Q==0) ;
assign CEO = ce & TC ;

always @ (posedge clr or posedge clk) begin
    if (clr) Q <= 0;
    else Q <= L? di : (up & ce)? Q+1 : (!up & ce)? Q-1 : Q ;
end

endmodule

module VCBD4SE(
    input clk,
    input ce,
    input s,

    output reg [3:0] Q = 4'hF,
    output wire TC,
    output wire CEO
);

assign TC = (Q==0) ;
assign CEO = ce & TC ;

always @ (posedge clk) begin
Q <= s? 4'hF : ce? Q-1 : Q ;
end

endmodule







