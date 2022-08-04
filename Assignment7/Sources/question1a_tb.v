
module question1a_tb;

reg [63:0] in;
reg [63:0] key;
wire [63:0] out;

question1 DUT (.in(in),.key(key),.out(out));

initial begin
in = 64'd0;
key = 64'd0;


end

endmodule
