module posedge_impulse(
  input clk,
  input in,

  output out
);

reg b;

always @(posedge clk) begin
  b <= in;
end

assign out = ((b ^ in) && (b == 0));

endmodule
