module ascii_to_hex (
  input [7:0]ascii,

  output reg [3:0]hex
);

always @(*) begin
  case(ascii)
    8'h30: hex = 4'h0;
    8'h31: hex = 4'h1;
    8'h32: hex = 4'h2;
    8'h33: hex = 4'h3;
    8'h34: hex = 4'h4;
    8'h35: hex = 4'h5;
    8'h36: hex = 4'h6;
    8'h37: hex = 4'h7;
    8'h38: hex = 4'h8;
    8'h39: hex = 4'h9;
    8'h61: hex = 4'hA;
    8'h41: hex = 4'hA;
    8'h62: hex = 4'hB;
    8'h42: hex = 4'hB;
    8'h63: hex = 4'hC;
    8'h43: hex = 4'hC;
    8'h64: hex = 4'hD;
    8'h44: hex = 4'hD;
    8'h65: hex = 4'hE;
    8'h45: hex = 4'hE;
    8'h66: hex = 4'hF;
    8'h46: hex = 4'hF;
    default: hex = 4'h0;
  endcase
end

endmodule
