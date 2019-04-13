module control(
  input [31:0]instr,

  output reg is_from_rf,
  output reg [11:0]imm12,
  output reg [2:0]alu_op,
  output reg rf_we   // register file write enable
);

wire [6:0]opcode = instr[6:0];
wire [2:0]funct3 = instr[14:12];
wire [4:0]funct5 = instr[31:27];
wire [1:0]funct2 = instr[26:25];

always @(*) begin
  rf_we = 1'b0;
  alu_op = 3'b0;
  imm12 = 12'b0;
  is_from_rf = 1'b0;

  casez ({funct5, funct2, funct3, opcode})
    17'bzzzzz_zz_000_0010011: begin // ADDI
      rf_we = 1'b1;
      alu_op = 3'h1;
      imm12 = instr[32:20];
      end
    17'bzzzzz_zz_100_0010011: begin // XORI
      rf_we = 1'b1;
      alu_op = 3'h2;
      imm12 = instr[32:20];
      end
    17'bzzzzz_zz_110_0010011: begin // ORI
      rf_we = 1'b1;
      alu_op = 3'h3;
      imm12 = instr[32:20];
      end
    17'bzzzzz_zz_111_0010011: begin // ANDI
      rf_we = 1'b1;
      alu_op = 3'h4;
      imm12 = instr[32:20];
      end
    17'b00000_00_000_0110011: begin // ADD
      rf_we = 1'b1;
      alu_op = 3'h1;
      is_from_rf = 1'b1;
      end
    17'b00000_00_100_0110011: begin // XOR
      rf_we = 1'b1;
      alu_op = 3'h2;
      is_from_rf = 1'b1;
      end
    17'b00000_00_110_0110011: begin // OR
      rf_we = 1'b1;
      alu_op = 3'h3;
      is_from_rf = 1'b1;
      end
    17'b00000_00_111_0110011: begin // AND
      rf_we = 1'b1;
      alu_op = 3'h4;
      is_from_rf = 1'b1;
      end
    default: ;
  endcase
end

endmodule
