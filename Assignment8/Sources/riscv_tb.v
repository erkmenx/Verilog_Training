module riscv_tb;

            reg enable;
            reg [31:0] A;
            reg [31:0] B;
            reg [2:0] selectoperation;
            reg [4:0] select_shifting;
            reg T;
            reg MF;
            wire V;
            wire C;
            wire Neg;
            wire Zero;
            wire [31:0] out;  
           
           
FU DUT(.A(A), .B(B), .selectoperation(selectoperation),.select_shifting(select_shifting),.T(T),.MF(MF),.V(V),.C(C),.Neg(Neg),.Zero(Zero),.out(out));            

initial begin
select_shifting = 5'd0;
T=0;
A = 32'h33333333;
B = 32'h33333333;
MF=0;   // SHIFTING 
selectoperation = 3'b100;
#20
select_shifting = 5'd2;
#20;
select_shifting = 5'd4;
#20; 
MF=1;
#20;
selectoperation = 3'b101;
#20;


end


endmodule
