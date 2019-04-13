module alu(
  input [31:0]src_a,
  input [31:0]src_b,
  input [2:0]op,

  output reg [31:0]res
);

always @(*) begin
  case (op)
    3'h0: res = src_a;
    3'h1: res = src_a + src_b;
    3'h2: res = src_a ^ src_b;
    3'h3: res = src_a | src_b;
    3'h4: res = src_a & src_b;
    default: res = 32'b0;
  endcase
end

endmodule
