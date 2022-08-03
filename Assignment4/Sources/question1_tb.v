module question1_tb;

reg clk = 0;
reg [63:0] a;
reg [63:0] b;
wire [127:0] out;

question1 DUT (.clk(clk), .a(a), .b(b), .out(out));
always begin
clk = ~clk;
#5;
end

initial begin
a = 64'd1387;
b = 64'd15870;
#100;
end

endmodule
