
module question1_tb;
reg clk = 0;
reg [7:0] D_IN;
reg start;
wire data;
wire busy;
wire [7:0] D_OUT;

question1 DUT (clk,D_IN,start,data,busy,D_OUT);

always begin
clk = ~clk;
#10;
end

initial begin
D_IN = 8'b01010101;
start = 0;
#200;
start = 1;
#200;
start = 0;
#200;
#8680000;
D_IN = 8'b11001100;
#20;
start=1;
#20;
start = 0;
#200;
#100;
#1000;
end

endmodule
