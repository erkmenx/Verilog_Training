module question1_tb;
reg clk = 0;
reg [9:0] in;
wire [9:0] data;
reg enable;
reg reset;
reg write_enable;
reg read_enable;

question1 DUT (.clk(clk), .in(in), .enable(enable), .write_enable(write_enable), .read_enable(read_enable),.reset(reset), .data(data));


always begin
clk = ~clk;
#10;
end

initial begin
reset = 1   ;
enable =1;
#20
reset = 0;
in = 10'd100;
write_enable = 1;
#20
read_enable = 1;
write_enable = 0;
in= 10'd250;
#20
read_enable=1;
write_enable=1;
#40
read_enable=0;
write_enable=1;
in = 10'd300;
#250
read_enable=1;
#500


#300;




end
endmodule
