module everything_tb;

reg clk = 0;
reg start;
reg rstn;
reg [7:0] a;
reg [7:0] b;
wire [8:0] resultout;

everything DUT (.clk(clk),.start(start), .rstn(rstn),.a(a),.b(b),.resultout(resultout));

always begin
    clk= ~clk;
    #5;
end

initial begin
    start = 0;
    rstn = 1;
    a = 0;
    b=0;
    #30;
    rstn = 0;
    #10
    a = 8'd29;
    b = 8'd21;
    start = 1;
    #300
 
    start = 0;
    #10
    rstn = 0;
    start = 1;
    #10
    a = 8'd37;
    b = 8'd129;
    #300
    #200
    
    
    
    
    $finish;
end

endmodule
