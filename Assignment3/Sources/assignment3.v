module everything(input clk,
                  input start,
                  input rstn,
                  input [7:0] a,
                  input [7:0] b,
                  output wire[8:0] resultout);
fsm u1(clk,rstn,start,rst,enable,load);
shifterinput u2(clk,enable,load,a,a0);
shifterinput u3(clk,enable,load,b,b0);
dl u4(clk,rst,carry,cin);
fulladder u5(a0,b0,cin,sum,carry);
shifteroutput u6(clk,enable,sum,rst,resultout);

endmodule


module shifterinput(input clk,
               input enable,
               input load,
               input [7:0] a,
               output reg shifted
               );
 reg [7:0] loaded;
always @(posedge clk) begin
    if(load)
    loaded <=a;

    if(enable)
    begin
    shifted <= loaded[0];
    loaded = loaded >>1;
    end
    else
    begin
    shifted <=0;
    loaded <=0;
    end
end        
endmodule

/////////////////////////////////////////////////
/////////////////////////////////////////////////
/////////////////////////////////////////////////
module shifteroutput(input clk,
                     input enable,
                     input a,
                     input rst,
                     output reg[8:0] sum);
                     
always @(posedge clk)begin
if(!rst)
sum<=0;
if(rst)
begin
if(enable)
begin
sum = sum >>1;
sum[8]=a;
end
end
end


endmodule


////////////////////////////////////////////////
////////////////////////////////////////////////
////////////////////////////////////////////////


module fsm(input clk,
           input rstn,
           input start,
           output reg rst,
           output reg enable,
           output reg load);  
reg controller =1;
reg [5:0] counter = 0;
always @(posedge clk)begin
if(rstn)
rst<=0;
if(!rstn)
rst <=1;

if(!start)
begin
controller = 1;
enable <=0;
load <=0;
counter <= 0;
end



if (start && controller && (counter==0))
begin
enable <=1;
load <=1;
counter <= counter +1;
end

else if (start && controller && (0<counter<=10))
begin
enable <=1;
load <=0;
counter <= counter +1;
end

if (start && controller && (counter>10))
begin
enable <=0;
load <=0;
counter <=0;
controller =~controller;
end



end
endmodule


//////////////////////////////////////////////////
/////////////////////////////////////////////////

module fulladder(
                input a,b,cin,
                output sum, carry
);
xor (out1,a,b);
xor (out2,out1,cin);
assign sum = out2;
and(out3,out1,cin);
and(out4,a,b);
or (out5,out3,out4);
assign carry = out5;

endmodule


//////////////////////////////////////////////////
//////////////////////////////////////////////////

module dl(input clk,
          input rst,
          input D,
          output reg Q
           );

always @(posedge clk) begin
if(!rst)
Q<=0;
if(rst)
Q<=D;
end
endmodule
