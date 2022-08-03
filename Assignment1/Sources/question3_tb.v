module question3_tb;

reg clk = 0, rst,a0;
wire [7:0] out;

question3 dut (.clk(clk), .rst(rst), .a0(a0), .out(out));

always begin
    clk= ~clk;
    #500;
    
end

initial begin
    rst = 0;
    a0=0;
    #15;
    rst = 1;
    a0=0;
    #300000000;
    #300000000;
    #300000000;
    #100000000;
    rst= 0;
    #50;
    rst=1;
    a0=1;
    #300000000;
    #300000000;
    #300000000;
    #100000000;
    $finish;
end

endmodule
