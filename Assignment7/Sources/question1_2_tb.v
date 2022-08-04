

module question1_2_tb;


reg [79:0] key;
reg [4:0] rcounter;
wire [79:0] key_out;


question1_2 DUT (.key(key),.rcounter(rcounter),.key_out(key_out));

initial begin
key = 80'h00000000000000000000;
rcounter = 5'b00000;
end
endmodule
