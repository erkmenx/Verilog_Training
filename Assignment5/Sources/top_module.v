module top_module#( parameter data_length = 8,
                    parameter data_depth =4)
(
input clk, 
input [data_length-1:0] in,
input write_enable_button,
input read_enable_button,
input reset,
output reg full,
output reg empty,
output reg [data_length-1:0] data

);
integer i;   
reg [data_length-1:0] memory [data_depth-1:0];
reg [$clog2(data_depth)-1:0] write_controller = 0;
reg [$clog2(data_depth)-1:0] read_controller = 0;
reg [data_depth-1:0]controller=0;
debouncer u1(clk,write_enable_button,write_enable);
debouncer u2(clk,read_enable_button,read_enable);
always @(posedge clk) begin

if(!reset)
    begin
                if(controller == data_depth)
                    full <= 1;
					else
				    full <=0;
                if(controller ==0)
                    empty <=1;       
					else
					empty<=0;
				
                if(!full)
                begin
                if(write_enable)
                    begin
                        memory[write_controller] <= in;
                        write_controller <= write_controller +1;
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
                        controller <=0;
                    end
            
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