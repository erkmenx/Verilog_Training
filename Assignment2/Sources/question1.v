module fulladder(
input a,b,cin,
output sum, carry
);
assign sum = (a ^^ b) ^^ cin;
assign carry = ((a & cin )|| (a&b) || (b&cin));
endmodule



module question1(
input clk,
input [31:0] a,
input [31:0] b,
output reg[32:0] out,
output [31:0] sum
    );

wire [31:0] carry;  
wire carry_out;
genvar i;
generate
for(i=0; i<32; i=i+1)begin
if(i == 0)
fulladder uX(a[0],b[0],0,sum[0],carry[0]);
else
fulladder uX(a[i],b[i],carry[i-1],sum[i],carry[i]);
end
assign carry_out = carry[31];
endgenerate


endmodule
