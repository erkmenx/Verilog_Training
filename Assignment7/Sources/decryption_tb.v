module decryption_tb;

reg clk=0;
reg start;
reg [63:0] ciphertext;
reg [79:0] key_in;
wire done;
wire [63:0] message;

decryption DUT (.clk(clk), .start(start),.ciphertext(ciphertext),.key_in(key_in),.done(done), .message(message));

always begin
clk = ~clk;
#10;
end



initial begin

start = 0;
ciphertext = 64'h3cf72a8b7518e6f7;
key_in = 80'h00000000000000000000;
//key_in = 80'hf5e2526885779338555a;
#200;
start = 1;
#20000;


end
endmodule
