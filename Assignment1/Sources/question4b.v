module question4b(
    input clk,rst,hz,control,
    output reg [3:0] out
);

reg[27:0] cnt2=0;
reg[27:0] cnt=0;
reg[3:0] reverse=0;

always @(posedge clk) begin

cnt <=cnt+1;
cnt2 <=cnt2+1;
    if (!rst)
        out <= 0;
    else
        begin
            if(!hz)
            begin
            if(control ==0)
                begin
                if(cnt>=25000000)
                    begin
                    out <= out + 1;
                    cnt <= 0;
                    end
                 end
            if(control==1)
                begin
                if(cnt>=25000000)
                    begin
                    out<=out-1;
                    cnt<=0; 
                    end
                end
                end
            if(hz)
            begin
            if(control ==0)
                begin
                if(cnt2>=250000)
                    begin
                    out <= out + 1;
                    cnt2 <= 0;
                    end
                 end
            if(control==1)
                begin
                if(cnt2>=250000)
                    begin
                    out<=out-1;
                    cnt2<=0; 
                    end
                end
  
             
            
                end
                end
end

endmodule
