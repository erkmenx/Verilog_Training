//******************************************************//
//******************TOP MODULE ************************//
//****************************************************//

module question2(
input clk,
input data,
input read_button,
input reset,
output tx_dataout,        // Txten ??kan data
output busy,
output [7:0] D_LED
);
wire [7:0] D_OUTTOP;
wire [7:0] txdata;
RX u1(.clk(clk),.data(data),.D_OUT(D_OUTTOP),.okay(okay));
FIFO u2(.clk(clk),.in(D_OUTTOP),.read_enable_button(read_button),.reset(reset),.okay(okay),.enable(enable),.data(D_LED),.txdata(txdata));
TX u3(.clk(clk),.D_IN(txdata),.enable(enable),.busy(busy),.data(tx_dataout));
endmodule

//******************************************************//
//******************TX MODULE**************************//
//****************************************************//

module TX#(parameter baudrate = 115200)(
input clk,
input [7:0] D_IN,
input enable,
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
    if(enable)
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
//******************************************************//
//******************RX MODULE**************************//
//****************************************************//

module RX#(parameter baudrate=115200)(
input clk,
input data,
output reg [7:0] D_OUT,
output reg okay);
reg [4:0] bit_counter = 0;
reg start=0;
reg old_data;
reg [7:0] memory=0;
reg [9:0] cnt3=0;
parameter clockborder = (50000000/baudrate);
reg [9:0] slwclk = 0;
reg clk2 = 0;

always @(posedge clk) begin
        old_data <= data;
        if(old_data && data ==0 && !start)
            begin
            start <=1;
            okay<=0;
            end
        else
            begin
            okay<=0;
            end
        if(start && (cnt3 >= (clockborder/2)))
             begin
             cnt3 = 0;
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
                okay<=1;
                end
            end    
        end
cnt3 <= cnt3+1;
slwclk <= slwclk+1;
end

endmodule

//******************************************************//
//******************FIFO MODULE************************//
//****************************************************//

module FIFO#( parameter data_length = 8,
                    parameter data_depth =4)
(
	input clk, 
	input [data_length-1:0] in,
	input read_enable_button,
	input reset,
	input okay,
    output reg enable,
	output reg [data_length-1:0] data,
	output reg [data_length-1:0] txdata

	);
	integer i;   
	reg [data_length-1:0] memory [data_depth-1:0];
	reg [$clog2(data_depth)-1:0] write_controller = 0;
	reg [$clog2(data_depth)-1:0] read_controller = 0;
	reg [data_depth-1:0]controller=0;
	reg [data_length-1:0] index_controller;
	reg full=0;
	reg full_old;
	reg empty=0;
	reg empty_old;
	debouncer u2(clk,read_enable_button,read_enable);
	always @(posedge clk) begin

	if(!reset)
		begin
					   
					if(controller == data_depth)
						begin
						full <= 1;
						txdata <= 8'd102;
						end
						
					else
						full <=0;
					if(controller ==0)
					begin
						empty <=1;
						txdata <= 8'd101;
					end
					else
						empty<=0;
					if((full_old == 0 & full == 1) || (empty_old ==0 & empty ==1))
					   enable <=1;
					else
					   enable <=0;
					   
					
					   
					if(!full)
					begin
					if(okay)
						begin
							memory[write_controller] <= in;
							write_controller <= write_controller +1;
							index_controller <=in;
							if(write_controller == data_depth-1)
							write_controller <=0;
							controller <= controller +1;
						end
					end
					if(read_enable && !empty)
						begin
							data <= memory[read_controller];
							read_controller <= read_controller +1;
							if(read_controller == data_depth-1)
							read_controller <=0;
							if(0<controller<=data_depth) 
							controller <= controller -1;
							if(controller == 0)
							begin
							controller <=0;
							end
						end
                    full_old <= full;
		            empty_old<=empty;
		end
	if(reset)
		begin
			for(i=0;i<=data_depth-1;i=i+1)begin
				memory[i]<=0;
			end
			full <=0;
			empty <=1;
			read_controller <=0;
			write_controller<=0;
			data <=0;
		end
	end
	endmodule

//******************************************************//
//******************DEBOUNCER MODULE*******************//
//****************************************************//

module debouncer(
	input clk,
	input button,
	output reg signal);
	reg [27:0] cnt=0;
	reg Q1=0;
	reg Q2=1;
	always @(posedge clk) begin
		
		if(cnt>=400000)
			begin
				Q1<=~button;
				Q2<=~Q1;
				signal <= Q2&&Q1;
				cnt<=0;
			end
		cnt<=cnt+1;

	end
	endmodule