module control(
  input [31:0]instr,

  output reg [11:0]imm12,
  output reg rf_we,   // register file write enable
  output reg [2:0]alu_op
);

wire [6:0]opcode = instr[6:0];
wire [2:0]funct3 = instr[14:12];

always @(*) begin
  rf_we = 1'b0;
  alu_op = 3'b0;
  imm12 = 12'b0;

  casez ({funct3, opcode})
    10'b000_0010011: begin // ADDI
      rf_we = 1'b1;
      alu_op = 3'h1;
      imm12 = instr[32:20];
      end
    10'b100_0010011: begin // XORI
      rf_we = 1'b1;
      alu_op = 3'h2;
      imm12 = instr[32:20];
      end
    10'b110_0010011: begin // ORI
      rf_we = 1'b1;
      alu_op = 3'h3;
      imm12 = instr[32:20];
      end
    10'b111_0010011: begin // ANDI
      rf_we = 1'b1;
      alu_op = 3'h4;
      imm12 = instr[32:20];
      end
    default: ;
  endcase
end

endmodule
