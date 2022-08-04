module question2_tb;
reg clk = 0;
reg data;
reg read_button;
reg reset;
wire data;
wire tx_dataout;
wire busy;
wire [7:0] D_LED;

question2 DUT (clk,data,read_button,reset,tx_dataout,D_LED);

always begin
clk = ~clk;
#10;
end

initial begin
reset = 1;
#20;
reset = 0;
#200
read_button = 1;
#50000000;
#20
#2000000;
data = 1;
#8680;
data = 1;
#8680;
data = 0;       //Start
#8680;
data = 1;       //1
#8680;
data = 1;       //2
#8680;
data = 1;       //3
#8680;
data = 1;       //4
#8680;
data = 1;       //5
#8680;
data = 0;       //6
#8680;
data = 0;       //7
#8680;
data = 0;       //8
#8680;
data=1;
#8680;
data = 1;
#868000;
data = 1;      //delay
#8680;
data = 0;       //Start
#8680;
data = 1;       // 1
#8680;
data = 0;       //2
#8680;
data = 1;      //3
#8680;
data = 0;       //4
#8680;
data = 0;       //5
#8680;
data = 1;       //6
#8680;
data = 0;       //7
#8680;
data=1;         //8
#8680;
data = 1;
#868000;
data = 1;      //delay
#8680;
data = 0;       //Start
#8680;
data = 1;       // 1
#8680;
data = 0;       //2
#8680;
data = 1;      //3
#8680;
data = 1;       //4
#8680;
data = 1;       //5
#8680;
data = 1;       //6
#8680;
data = 0;       //7
#8680;
data=1;         //8
#8680;
data = 1;      //delay
#8680;
data = 0;       //Start
#8680;
data = 1;       // 1
#8680;
data = 0;       //2
#8680;
data = 1;      //3
#8680;
data = 1;       //4
#8680;
data = 1;       //5
#8680;
data = 1;       //6
#8680;
data = 0;       //7
#8680;
data=1;         //8
#8680;
data = 1;      //delay
#8680;
#2000000;
read_button = 0;
#2000000;
read_button = 1;
#200000000;
read_button = 0;
#2000000;
read_button = 1;
#200000000;
read_button = 0;
#2000000;
end


endmodule
