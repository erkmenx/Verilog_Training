
module combineboth_tb;

reg clk = 0;
reg [79:0] master_key;
reg [63:0] plain_text;
reg rst;
reg start;
wire [63:0] out;
wire ended;


combineboth BIGBOSS (.clk(clk),.master_key(master_key),.plain_text(plain_text),.rst(rst),.start(start),.out(out),.ended(ended));

always begin
clk = ~clk;
#10;
end


initial begin
master_key = 80'h00000000000000000000;
plain_text = 64'h7777aaaa3333eeee;
rst = 1;
#200
rst = 0;
start = 1;
#2000;
rst=1;
master_key = 80'h00000000000000000000;
plain_text = 64'hBABABABABABABABABABA;
#200;
rst=0;
#2000;

end
endmodule
