module question1#( parameter data_length = 10)
(
input clk, 
input [data_length-1:0] in,
input enable,
input write_enable,
input read_enable,
input reset,
output reg [data_length-1:0] data

);
    
reg [data_length-1:0] memory;
reg [$clog2(data_length)-1:0] write_controller = 0;
reg [$clog2(data_length)-1:0] read_controller = 0;


always @(posedge clk) begin
if(!reset)
    begin
        if(enable)
            begin
                if(write_enable)
                    begin
                        memory <= in;
                    end
                if(read_enable)
                    begin
                        data <= memory;
                    end
            end
    end
else
memory<=0;
end
endmodule