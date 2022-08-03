module question4c(
    input clk,rst,hz,button,
    output reg [3:0] out
);
reg[27:0] cnt3=0;
reg[27:0] cnt2=0;
reg[27:0] cnt=0;
reg [63:0] debouncer = 64'd0;
reg control2 = 0;
reg control = 0;
reg inverse = 0;
always @(posedge clk) begin
cnt <=cnt+1;
cnt2 <=cnt2+1;
cnt3 <= cnt3+1;
        if(cnt3>=75000)
        begin
           cnt3<=0;
           if (control2 ==1)
               debouncer = 64'hFFFFFFFFFFFFFFFF;
           debouncer[0] = button;
           debouncer = debouncer << 1;
           
           if(debouncer == 64'd0)
           control2 <=1;
           else
           control2 <=0;
                   
           
           if (control2==1)
           inverse <=~inverse;
           else
           inverse <= inverse;            
         end
 


    if (!rst)
        out <= 0;
    else
        begin
            if(!hz)
            begin
            if(inverse ==0)
                begin
                if(cnt>=25000000)
                    begin
                    out <= out + 1;
                    cnt <= 0;
                    end
                 end
            if(inverse==1)
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
            if(inverse ==0)
                begin
                if(cnt2>=250000)
                    begin
                    out <= out + 1;
                    cnt2 <= 0;
                    end
                 end
            if(inverse==1)
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
