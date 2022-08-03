module question2_tb;

reg clk_in = 0,rst;
reg x1,x2;
wire clk_out,clk_out4,clk_out3,clk_out2,clk_out1,Q1,Q2,Q3,Q4,D1,D2,D3,D4;

question2 DUT (.x1(x1), .x2(x2), .clk_in(clk_in), .rst(rst), .D1(D1), .D2(D2), .D3(D3), .D4(D4), .Q1(Q1), .Q2(Q2), .Q3(Q3), .Q4(Q4), .clk_out1(clk_out1),.clk_out2(clk_out2),.clk_out3(clk_out3),.clk_out4(clk_out4),.clk_out(clk_out));

always begin
    clk_in =  ~clk_in;
    #5;
end

initial begin
    rst = 0;
    x1 = 0;
    x2=0;
    #15
    rst = 1;
    x1 = 0;
    x2 = 0; 
    #100;
    x1 = 0;
    x2 = 1;
    #100;
    x1 = 1;
    x2 = 0;
    #100;
    x1 = 1;
    x2 = 1;
    #100;
    $finish;
end

endmodule 