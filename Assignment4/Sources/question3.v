module question3(
input clk,
input [63:0] a,
input [63:0] b,
output reg[127:0] out

    );
reg[127:0] x1;
reg[127:0] x2;
reg[127:0] x3;
always @(posedge clk) begin
x1 <= (2^64)*a[63:32]*b[63:32];
x2 <=((2^32)*(a[31:0]*b[63:32]+a[63:32]*b[31:0]));
x3 <= a[31:0]*b[31:0];

out <= x1+x2+x3;
end
endmodule
