`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.06.2022 15:33:38
// Design Name: 
// Module Name: question1_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module question1_tb;

reg clk = 0,rst,x;
wire [2:0] out;

question1 dut (.clk(clk), .rst(rst), .x(x), .out(out));

always begin
    clk= ~clk;
    #10;
end

initial begin
    rst = 1;
    #20;
    x = 1;
    #20
    #20
    #20
    #20
    #20
    #20
    #20
    x=0;
    #20
    #20
    #20
    #20
    #20
    #20
    #20
    rst = 0;
    #200;
    $finish;
end

endmodule
