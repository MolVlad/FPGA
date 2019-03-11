module uart_queue (
  input clk,
  input [15:0]data,
  input flag_start,

  output out
);

wire [3:0]current_data;

reg [1:0]i = 3;

always @(negedge flag_busy) begin
  i <= i - 1;
end

assign current_data = data[i * 4 +: 4];

wire uart_start, flag_busy;


reg b = 0;

always @(posedge clk) begin
  b <= ~flag_busy;
end

assign uart_start = (flag_start || ((~flag_busy ^ b) && (b == 0) && (i != 3)));

wire [7:0]ascii;

hex_to_ascii hex_to_ascii(.hex(current_data), .ascii(ascii));

uart_out uart_out(.clk(clk), .data(ascii), .out(out), .flag_start(uart_start), .flag_busy(flag_busy));

endmodule
