module question2_tb;

reg clk = 0;
reg [63:0] a;
reg [63:0] b;
wire [127:0] out;

question2 DUT (.clk(clk), .a(a), .b(b), .out(out));
always begin
clk = ~clk;
#5;
end

initial begin
a = 64'd1324897;
b = 64'd13578;
#100;
end

endmodule
