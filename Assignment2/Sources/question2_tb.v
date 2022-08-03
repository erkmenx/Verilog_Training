module question2_tb;

reg clk = 0;
reg [31:0] a;
reg [31:0] b;

wire [31:0] sum;

question2 DUT (.clk(clk), .a(a), .b(b), .sum(sum));

always begin
    clk= ~clk;
    #10;
end

initial begin

    a = 32'd2147483647;
    b = 32'd0;
    #40000;
    
    a= 32'd2049;
    b = 32'd891;
    #5000
    $finish;
end

endmodule
