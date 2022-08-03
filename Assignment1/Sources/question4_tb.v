
module question4_tb;
reg clk = 0, rst,hz;
wire [3:0] out;




question4 dut (.hz(hz),.clk(clk), .rst(rst),.out(out));

always begin
    clk= ~clk;
    #5;
end

initial begin
rst = 0;
hz = 0;
#15;
rst = 1;
#200;
hz = 1;
end
endmodule
