module alu(
  input [31:0]src_a,
  input [31:0]src_b,
  input [4:0]op,

  output reg [31:0]res
);

reg signed [31:0]a_signed;
reg signed [31:0]b_signed;

always @(*) begin
  case (op)
    5'h0: res = src_a;
    5'h1: res = src_a + src_b;
    5'h2: res = src_a ^ src_b;
    5'h3: res = src_a | src_b;
    5'h4: res = src_a & src_b;
    5'h5: res = src_a - src_b;
    5'h6: res = (src_a < src_b) ? 32'h1 : 32'h0;
    5'h7: res = src_a << src_b[4:0];
    5'h8: res = src_a >> src_b[4:0];
    5'h9: begin
      a_signed = src_a;
      res = a_signed >>> src_b[4:0];
    end
    5'hA: begin
      a_signed = src_a;
      b_signed = src_b;
      res = (a_signed < b_signed) ? 32'h1 : 32'h0;
    end
    default: res = 32'b0;
  endcase
end

endmodule
