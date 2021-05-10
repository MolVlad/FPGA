`include "const.v"

module SPI_MASTER(
    input clk,
    input st,
    input [`m-1:0] MTX_DAT,
    input MISO,

    output MOSI,
    output reg SCLK = 0,
    output reg LOAD = 1,
    output reg [`m-1:0] MRX_DAT = 0
);

wire [`m-1:0] sr_rx;
reg [7:0] cb_bit = 0;
reg [7:0] cb_tact = 8'h0;
reg [`m-1:0] sr_MTX = 0;
reg [`m-1:0] sr_MRX = 0;

assign final_bit = (cb_bit == `m-1) & ce_tact;
assign START = st & LOAD;
assign ce = cb_tact == `Nce - 1;
assign ce_tact = ce & SCLK;
assign MOSI = sr_MTX[`m-1];

always @ (posedge clk) begin
    LOAD <= st ? 0 : final_bit ? 1 : LOAD;
    cb_tact <= (START | ce) ? 0 : cb_tact + 1;
    SCLK <= LOAD ? 0 : ce ? !SCLK : SCLK;
    cb_bit <= START ? 0 : ce_tact ? cb_bit + 1 : cb_bit;
    sr_MTX <= LOAD ? MTX_DAT : ce_tact ? (sr_MTX[`m-2:0] << 1) : sr_MTX;
end

always @ (posedge SCLK) begin
    sr_MRX <= (sr_MRX[`m-2:0] << 1) | MISO;
end

always @ (posedge LOAD) begin
    MRX_DAT <= sr_MRX;
end

endmodule

module SPI_SLAVE(
    input MOSI,
    input LOAD,
    input SCLK,
    input [`m-1:0] STX_DAT,

    output MISO,
    output reg [`m-1:0] SRX_DAT = 0);

reg [`m-1:0] sr_STX = 0;
reg [`m-1:0] sr_SRX = 0;

assign MISO = sr_STX[`m-1];

always @ (posedge LOAD or negedge SCLK) begin
    sr_STX <= LOAD ? STX_DAT : sr_STX[`m-2:0] << 1;
end

always @ (posedge SCLK) begin
    sr_SRX <= (sr_SRX[`m-2:0] << 1) | MOSI;
end

always @ (posedge LOAD) begin
    SRX_DAT <= sr_SRX;
end

endmodule



