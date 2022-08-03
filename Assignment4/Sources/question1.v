module question1(
input clk,
input [63:0] a,
input [63:0] b,
output reg[127:0] out

    );
    
always @(posedge clk) begin
out <= a*b;
end
endmodule
