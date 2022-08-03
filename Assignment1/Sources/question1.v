module counter(
    input clk, rst,inx,
    output reg [2:0] out
);

// File and modules names must be the same!!

always @(posedge clk) begin
    if (!rst)
        out <= 0;
    else
        if(!inx)
        out <= out - 1;
        else
        out <= out+1;
end

endmodule
