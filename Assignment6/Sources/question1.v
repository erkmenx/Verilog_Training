module question1(
input clk,
input [7:0] D_IN,
input start,
output data,
output busy,
output [7:0] D_OUT
);
TX u2(clk,D_IN,start,busy,data);
RX u3(clk,busy,data,D_OUT);
endmodule



module TX#(parameter baudrate = 115200)(
input clk,
input [7:0] D_IN,
input start,
output reg busy=0,
output reg data
);
parameter clockborder= (50000000/baudrate);
reg [8:0] notshifted = 0;
reg [8:0] memory = 0;
reg [4:0] bit_counter = 0;
reg [9:0] slwclk = 0;
reg clk2 = 0;
always @(posedge clk)
begin
    if(start)
        busy<=1;
    if(!busy)
        begin
            notshifted <= D_IN;
            memory <= notshifted <<1;
            slwclk= 16'd0;
            data<=1;
        end
    if(busy)
        begin
            if(slwclk>=(clockborder-1))
            begin
            clk2<=~clk2;
            slwclk=0;
            if(0<=bit_counter<=8)
                begin
                data<=memory[0];
                memory <= memory >>1;
                bit_counter<=bit_counter+1;                
                end
            if(bit_counter == 9)
                begin
                bit_counter<=0;
                data <=1;
                busy<=0;
                end
            end    
        end

slwclk <= slwclk+1;
end
endmodule


module RX#(parameter baudrate=115200)(
input clk,
input enable,
input data,
output reg [7:0] D_OUT);
reg [4:0] bit_counter = 0;
reg start=0;
reg old_data;
reg [7:0] memory=0;
parameter clockborder = (50000000/baudrate);
reg [9:0] slwclk = 0;
reg clk2 = 0;

always @(posedge clk) begin
        old_data <= data;
        if(old_data && data ==0 && !start)
            begin
            start <=1;
            end
        if(start)
             begin
            if(slwclk>=(clockborder-1))
            begin
            clk2<=~clk2;
            slwclk=0;
            if(0<=bit_counter<=7)
                begin
                memory <= memory >>1;
                memory[7]<=data;
                bit_counter<=bit_counter+1;                
                end
            if(bit_counter == 8)
                begin
                bit_counter <=bit_counter+1;
                end
            if(bit_counter == 9)
                begin
                D_OUT<=memory;
                memory <=0;
                start <=0;
                bit_counter<=0;
                end
            end    
        end

slwclk <= slwclk+1;
end

endmodule
