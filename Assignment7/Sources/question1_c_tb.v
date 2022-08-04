
module question1_c_tb;

reg clk=0;
reg [63:0] plain_text;
reg [79:0] master_key;
reg rst;
reg start;
wire [63:0] out;
wire done;

question1_c DUT (.clk(clk),.plain_text(plain_text),.master_key(master_key),.rst(rst),.start(start),.out(out),.done(done));

always begin
clk = ~clk;
#10;
end

initial begin
plain_text = 64'd0;
master_key = 80'd0;
rst = 1;
start =0;
#40
rst=0;
start = 1;


end
endmodule
