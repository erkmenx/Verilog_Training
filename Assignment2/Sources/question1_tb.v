module counter_tb;

reg clk = 0;
reg [31:0] a;
reg [31:0] b;

wire [31:0] sum;

question1 DUT (.clk(clk), .a(a), .b(b), .sum(sum));

always begin
    clk= ~clk;
    #5;
end

initial begin
    a = 0;
    b= 0;
    #20;
    a = 32'd100;
    b = 32'd150;
    #400;
    
    a= 32'd2049;
    b = 32'd891;
    #500
    $finish;
end

endmodule
