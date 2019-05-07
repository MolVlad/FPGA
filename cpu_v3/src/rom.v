module rom #(parameter ADDR_WIDTH = 5, parameter WIDTH = 32)(
    input [ADDR_WIDTH - 1:0]addr,
    input clk,
    output reg [WIDTH - 1:0]q
);

reg [WIDTH - 1:0]mem[2**ADDR_WIDTH - 1:0];

initial begin
    $readmemh("../src/samples/test.txt", mem);
end

always @(posedge clk) begin
    q <= mem[addr];
end

endmodule

