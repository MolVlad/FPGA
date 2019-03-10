module uart_queue (
  input clk,
  input [15:0]data,
  input flag_start,

  output out
);

reg [3:0]current_data;

reg [1:0]i;

always @(negedge flag_busy) begin
  i <= i + 1;

  current_data <= data[i * 4 +: 4];
end

reg b = 0;

wire flag_busy;

always @(posedge clk) begin
  if(flag_start == 1)
    b <= 1;

  b <= flag_busy;
end

wire uart_start;

assign uart_start = ((flag_busy ^ b) && (b == 1));

wire [7:0]ascii;

hex_to_ascii hex_to_ascii(.hex(current_data), .ascii(ascii));

uart_out uart_out(.clk(clk), .data(ascii), .out(out), .flag_start(uart_start), .flag_busy(flag_busy));

endmodule
