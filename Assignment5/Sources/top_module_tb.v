module top_module_tb;

reg clk=0;
reg [7:0] in;
reg write_enable_button;
reg read_enable_button;
reg reset;
wire empty;
wire full;
wire [7:0] data;


top_module DUT (.clk(clk), .in(in),.write_enable_button(write_enable_button),.read_enable_button(read_enable_button),.reset(reset),.full(full),.empty(empty),.data(data));

always begin
clk =  ~clk;
#5;
end

initial begin
reset=1;
#10;
reset=0;
write_enable_button=1;
in = 8'd21;
#4500000;
#1000000;
write_enable_button = 0;
read_enable_button = 0;
#100;
in = 8'd29;
#4500000;
#1000000;
write_enable_button = 1;
#4500000;
#1000000;
write_enable_button =0;
#4500000;
#1000000;
write_enable_button = 1;
in = 8'd129;
#4500000;
#4500000;
#1000000;
write_enable_button =0;
#1000000;
in = 8'd169;
#4500000;
#1000000;
write_enable_button = 1;
#4500000;
#1000000;
write_enable_button =0;
#4500000;
#4500000;
#1000000;
in = 8'd30;
#4500000;
#1000000;
in = 8'd25;
#4500000;
#1000000;
write_enable_button=1;
#1000000;

write_enable_button=0;
#20;
read_enable_button =1;
#1000000;
read_enable_button =0;
#1000000;
read_enable_button =1;
#1000000;
read_enable_button=0;
in= 8'd30;
#15;
write_enable_button=1;
#1000000;
write_enable_button=0;
#200000;
end

endmodule
