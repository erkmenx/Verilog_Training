`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.06.2022 08:26:07
// Design Name: 
// Module Name: question2
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


module question2(
    input rst,
    input x1,x2,
    input wire D1,D2,D3,D4,
    input wire clk_in,
    output wire clk_out4,clk_out3,clk_out2,clk_out1,
    output reg Q1,Q2,Q3,Q4,clk_out
 );
    always @(posedge clk_in) begin
        if(!rst)
           Q1 <= 1'b0;
        else
           Q1 <= D1;
    end 
assign D1 = ~Q1;
assign clk_out1=Q1;

    always @(posedge ~Q1) begin
        if(!rst)
           Q2 <= 1'b0;
        else
           Q2 <= D2;       
end     
assign D2 = ~Q2;
assign clk_out2=Q2;


    always @(posedge ~Q2) begin
        if(!rst)
           Q3 <= 1'b0;
        else
           Q3 <= D3;       
end     
assign D3 = ~Q3;
assign clk_out3=Q3;

    always @(posedge ~Q3) begin
        if(!rst)
           Q4 <= 1'b0;
        else
           Q4 <= D4;       
end     

assign D4 = ~Q4;
assign clk_out4 = Q4;
always@(*) begin
       if(x1 == 0 & x2==0)
            clk_out <= Q1;
       else if(x1 == 0 & x2==1)
            clk_out <= Q2;
       else if(x1 == 1 & x2==0)
             clk_out <= Q3;
       else
             clk_out <= Q4; 
end
                        

endmodule
