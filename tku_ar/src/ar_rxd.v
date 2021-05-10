module AR_RXD (
    input clk,
    input [1:0] Nvel,
    input Inp0,
    input Inp1,

    output reg [7:0] sr_adr = 0,
    output reg [22:0] sr_dat = 0,
    output wire  ce_wr
);

parameter Fclk=50000000 ; //50 MHz
parameter V1Mb=1000000 ; // 1000 kb/s
parameter V100kb=100000 ; // 100 kb/s
parameter V50kb= 50000 ; // 50 kb/s
parameter V12_5kb=12500 ; // 12.5 kb/s
wire [10:0]AR_Nt = (Nvel [1:0]==3)? (Fclk/(2*V1Mb)) : //1000.000 kb/s
    (Nvel [1:0]==2)? (Fclk/(2*V100kb)) : // 100.000 kb/s
    (Nvel [1:0]==1)? (Fclk/(2*V50kb)) : // 50.000 kb/s
    (Fclk/(2*V12_5kb)); // 12.500 kb/s

reg FT_cp_rx = 0; //T-триггер контроля четности

reg [6:0] cb_bit_rx = 0;
reg en_rx = 0;
reg [10:0] cb_res = 0; // счетчик паузы
reg [2:0] cb_bit_res = 0;

assign RXCLK = Inp0 | Inp1;
assign T_cp = (cb_bit_rx == 32);
assign res = cb_bit_res == 4;
assign ce_bit_res = cb_res == AR_Nt * 2;
assign en_adr = cb_bit_rx < 8;
assign en_dat = (cb_bit_rx >= 8) & (cb_bit_rx < 31);
assign ce_wr = T_cp & FT_cp_rx;

always @ (posedge clk) begin
    en_rx <= RXCLK ? 1 : res ? 0 : en_rx;
    cb_res <= (RXCLK | ce_bit_res) ? 0 : cb_res + 1;
    cb_bit_res <= RXCLK ? 0 : ce_bit_res ? cb_bit_res + 1 : cb_bit_res;
end

always @ (posedge RXCLK) begin
    sr_adr <= en_adr ? (sr_adr[6:0] << 1) | Inp1 : sr_adr;
    sr_dat <= en_dat ? sr_dat[22:1] | (Inp1 << 22) : sr_dat;
end

always @ (posedge RXCLK or posedge res) begin
    cb_bit_rx <= res? 0 : cb_bit_rx + 1;
    FT_cp_rx <= res ? 0 : Inp1 ? !FT_cp_rx : FT_cp_rx;
end

endmodule


