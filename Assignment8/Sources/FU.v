module FU( 
            input [31:0] A,
            input [31:0] B,
            input [2:0] selectoperation,
            input [4:0] select_shifting,
            input T,
            input MF,
            output V,
            output C,
            output Neg,
            output Zero,
            output reg[31:0] out           
    );
    
localparam SHIFT = 0;
localparam ALU_ = 1;
wire [31:0] outALU;
wire [31:0] outSHIFTER; 
ALU u1(.A(A),.B(B),.sel(selectoperation),.out(outALU),.V(V),.C(C),.Neg(Neg),.Zero(Zero));
testingproject u2(.B(B),.S(select_shifting),.T(T),.out(outSHIFTER));


always @(*) begin

case(MF)
    SHIFT:
    out<=outSHIFTER;
    ALU_:
    out<=outALU;
endcase
end
endmodule
