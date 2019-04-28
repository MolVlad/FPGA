module control(
  input [31:0]instr,

  output reg is_from_rf,
  output reg [11:0]imm12,
  output reg [4:0]alu_op,
  output reg rf_we,   // register file write enable
  output reg mem_we,   // memory write enable
  output reg branch,
  output reg is_invert
);

wire [6:0]opcode = instr[6:0];
wire [2:0]funct3 = instr[14:12];
wire [4:0]funct5 = instr[31:27];
wire [1:0]funct2 = instr[26:25];

always @(*) begin
  rf_we = 1'b0;
  alu_op = 5'b0;
  imm12 = 12'b0;
  is_from_rf = 1'b0;
  mem_we = 1'b0;
  branch = 1'b0;
  is_invert = 1'b0;

  casez ({funct5, funct2, funct3, opcode})
    17'bzzzzz_zz_000_0010011: begin // ADDI
      rf_we = 1'b1;
      alu_op = 5'h1;
      imm12 = instr[31:20];
      end
    17'bzzzzz_zz_100_0010011: begin // XORI
      rf_we = 1'b1;
      alu_op = 5'h2;
      imm12 = instr[31:20];
      end
    17'bzzzzz_zz_110_0010011: begin // ORI
      rf_we = 1'b1;
      alu_op = 5'h3;
      imm12 = instr[31:20];
      end
    17'bzzzzz_zz_111_0010011: begin // ANDI
      rf_we = 1'b1;
      alu_op = 5'h4;
      imm12 = instr[31:20];
      end
    17'bzzzzz_zz_011_0010011: begin // SLTIU
      rf_we = 1'b1;
      alu_op = 5'h6;
      imm12 = instr[31:20];
      end
    17'bzzzzz_zz_010_0010011: begin // SLTI
      rf_we = 1'b1;
      alu_op = 5'hA;
      imm12 = instr[31:20];
      end
    17'b00000_00_001_0010011: begin // SLLI
      rf_we = 1'b1;
      alu_op = 5'h7;
      imm12 = instr[31:20];
      end
    17'b00000_00_101_0010011: begin // SRLI
      rf_we = 1'b1;
      alu_op = 5'h8;
      imm12 = instr[31:20];
      end
    17'b01000_00_101_0010011: begin // SRAI
      rf_we = 1'b1;
      alu_op = 5'h9;
      imm12 = instr[31:20];
      end
    17'b00000_00_000_0110011: begin // ADD
      rf_we = 1'b1;
      alu_op = 5'h1;
      is_from_rf = 1'b1;
      end
    17'b00000_00_100_0110011: begin // XOR
      rf_we = 1'b1;
      alu_op = 5'h2;
      is_from_rf = 1'b1;
      end
    17'b00000_00_110_0110011: begin // OR
      rf_we = 1'b1;
      alu_op = 5'h3;
      is_from_rf = 1'b1;
      end
    17'b00000_00_111_0110011: begin // AND
      rf_we = 1'b1;
      alu_op = 5'h4;
      is_from_rf = 1'b1;
      end
    17'b01000_00_000_0110011: begin // SUB
      rf_we = 1'b1;
      alu_op = 5'h5;
      is_from_rf = 1'b1;
      end
    17'b00000_00_001_0110011: begin // SLL
      rf_we = 1'b1;
      alu_op = 5'h7;
      is_from_rf = 1'b1;
      end
    17'b00000_00_101_0110011: begin // SRL
      rf_we = 1'b1;
      alu_op = 5'h8;
      is_from_rf = 1'b1;
      end
    17'b01000_00_101_0110011: begin // SRA
      rf_we = 1'b1;
      alu_op = 5'h9;
      is_from_rf = 1'b1;
      end
    17'b00000_00_011_0110011: begin // SLTU
      rf_we = 1'b1;
      alu_op = 5'h6;
      is_from_rf = 1'b1;
      end
    17'b00000_00_010_0110011: begin // SLT
      rf_we = 1'b1;
      alu_op = 5'hA;
      is_from_rf = 1'b1;
      end
    17'bzzzzz_zz_010_0100011: begin // SW
      alu_op = 5'h1;
      mem_we = 1'b1;
      imm12 = {instr[31:25], instr[11:7]};
      end
    17'bzzzzz_zz_001_1100011: begin // BNE
      alu_op = 5'h2;
      branch = 1'b1;
      is_from_rf = 1'b1;
      is_invert = 1'b0;
      imm12 = {{2{instr[31]}}, instr[7], instr[30:25], instr[11:9]};
      end
    17'bzzzzz_zz_000_1100011: begin // BEQ
      alu_op = 5'h2;
      branch = 1'b1;
      is_from_rf = 1'b1;
      is_invert = 1'b1;
      imm12 = {{2{instr[31]}}, instr[7], instr[30:25], instr[11:9]};
      end
    17'bzzzzz_zz_100_1100011: begin // BLT
      alu_op = 5'h6;
      branch = 1'b1;
      is_from_rf = 1'b1;
      is_invert = 1'b0;
      imm12 = {{2{instr[31]}}, instr[7], instr[30:25], instr[11:9]};
      end
    17'bzzzzz_zz_101_1100011: begin // BGE
      alu_op = 5'h6;
      branch = 1'b1;
      is_from_rf = 1'b1;
      is_invert = 1'b1;
      imm12 = {{2{instr[31]}}, instr[7], instr[30:25], instr[11:9]};
      end
    17'bzzzzz_zz_110_1100011: begin // BLTU
      alu_op = 5'hA;
      branch = 1'b1;
      is_from_rf = 1'b1;
      is_invert = 1'b0;
      imm12 = {{2{instr[31]}}, instr[7], instr[30:25], instr[11:9]};
      end
    17'bzzzzz_zz_111_1100011: begin // BGEU
      alu_op = 5'hA;
      branch = 1'b1;
      is_from_rf = 1'b1;
      is_invert = 1'b1;
      imm12 = {{2{instr[31]}}, instr[7], instr[30:25], instr[11:9]};
      end
    default: ;
  endcase
end

endmodule
