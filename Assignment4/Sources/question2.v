module question2(
input clk,
input [63:0] a,
input [63:0] b,
output reg[127:0] out

    );

always @(posedge clk) begin
out <= (2^64)*a[63:32]*b[63:32]+ ((2^32)*(a[31:0]*b[63:32]+a[63:32]*b[31:0]))+ a[31:0]*b[31:0];
end
endmodule
