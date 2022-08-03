module question3(
    input clk,a0,rst,
    output reg[7:0] out=0
);

reg speed =0; 
reg[27:0] cnt=0;




// File and modules names must be the same!!

always @(posedge clk) begin
    cnt <= cnt+1;
    if (!rst)
    begin
        out <= 0;
        cnt<=0;
    end
    else
        begin
            if(!a0)
                begin
                    if(cnt>=500000 && out>=128)
                        begin
                            out<=0;
                            cnt<=0;
                        end
                     if( cnt>=500000 && out<128)
                        begin
                            out<=out+1;
                            cnt<=0;
                        end
                 end
            if(a0)
                begin
                    if(cnt>=250000 && out>=128)
                        begin
                        out<=0;
                        cnt<=0;
                        end
                    if(cnt>=250000 && out<128)
                        begin
                        out<=out+1;
                        cnt<=0;                         
                        end             
                end
        end                
                        
end                   
endmodule
