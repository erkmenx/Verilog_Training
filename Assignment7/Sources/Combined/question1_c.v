module question1_c(
            input clk,
            input [63:0] plain_text,
            input [79:0] master_key,
            input rst,
            input start,
            output reg [63:0] out,
            output reg done);
         
reg  [4:0] rcounter = 0;
reg [63:0] plain_text_new=0;
wire [63:0] new_cipher_text;
reg [79:0] key_in;
wire [79:0] new_key;
reg [63:0] cipher_old;
reg [79:0] key_old;
integer i=0;
    KEY_SCHEDULE p7 (.key(key_in),.rcounter(rcounter),.key_out(new_key));
    round_module o7 (.in(plain_text_new),.key_in(key_in),.out(new_cipher_text));
    
always @(posedge clk) begin
if(rst)
    begin
    done =0;
    out =0;
    rcounter =0;
    plain_text_new=plain_text;
    key_in=master_key;
    end
else
    begin
            if(0<=rcounter <= 24 && !done)
            begin
                if(start)
                begin
                key_in<=new_key;
                plain_text_new <= new_cipher_text;
                rcounter <=rcounter+1;
                end
            end
        if(rcounter == 24)
        begin
        key_old <= new_key;
        cipher_old <= new_cipher_text;
        end
        if(rcounter == 24)
        begin
        out <= new_key ^new_cipher_text;
         done<=1;
        end 
    end
end
endmodule




module round_module(input [63:0] in,
                 input [79:0] key_in,
                 output [63:0] out
    );
wire [79:0] key;
wire [63:0] step1;
wire [3:0] S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15,S16;
wire [3:0] Block1_1,Block1_2,Block1_3,Block1_4;
wire [3:0] Block2_1,Block2_2,Block2_3,Block2_4;
wire [3:0] Block3_1,Block3_2,Block3_3,Block3_4;
wire [3:0] Block4_1,Block4_2,Block4_3,Block4_4;
wire [15:0] BLOCK1_OUT,BLOCK1_OKAY;
wire [15:0] BLOCK2_OUT,BLOCK2_OKAY;
wire [15:0] BLOCK3_OUT,BLOCK3_OKAY;
wire [15:0] BLOCK4_OUT,BLOCK4_OKAY;
ADD_ROUND_KEY u1(.in(in),.key(key_in),.out(step1));
SBOX_Layer_64to4 u2(.in(step1),.S1(S1),.S2(S2),.S3(S3),.S4(S4),.S5(S5),.S6(S6),.S7(S7),.S8(S8),.S9(S9),.S10(S10),.S11(S11),.S12(S12),.S13(S13),.S14(S14),.S15(S15),.S16(S16)); 
SBOX_LAYER SBOX1_1(.in(S1),.out(Block1_1));
SBOX_LAYER SBOX1_2(.in(S2),.out(Block1_2));
SBOX_LAYER SBOX1_3(.in(S3),.out(Block1_3));
SBOX_LAYER SBOX1_4(.in(S4),.out(Block1_4));
SBOX_LAYER SBOX2_1(.in(S5),.out(Block2_1));
SBOX_LAYER SBOX2_2(.in(S6),.out(Block2_2));
SBOX_LAYER SBOX2_3(.in(S7),.out(Block2_3));
SBOX_LAYER SBOX2_4(.in(S8),.out(Block2_4));
SBOX_LAYER SBOX3_1(.in(S9),.out(Block3_1));
SBOX_LAYER SBOX3_2(.in(S10),.out(Block3_2));
SBOX_LAYER SBOX3_3(.in(S11),.out(Block3_3));
SBOX_LAYER SBOX3_4(.in(S12),.out(Block3_4));
SBOX_LAYER SBOX4_1(.in(S13),.out(Block4_1));
SBOX_LAYER SBOX4_2(.in(S14),.out(Block4_2));
SBOX_LAYER SBOX4_3(.in(S15),.out(Block4_3));
SBOX_LAYER SBOX4_4(.in(S16),.out(Block4_4));
BLOCK_SHUFFLE BLCK1(.in0(Block1_1),.in1(Block1_2),.in2(Block1_3),.in3(Block1_4),.out(BLOCK1_OUT));
BLOCK_SHUFFLE BLCK2(.in0(Block2_1),.in1(Block2_2),.in2(Block2_3),.in3(Block2_4),.out(BLOCK2_OUT));
BLOCK_SHUFFLE BLCK3(.in0(Block3_1),.in1(Block3_2),.in2(Block3_3),.in3(Block3_4),.out(BLOCK3_OUT));
BLOCK_SHUFFLE BLCK4(.in0(Block4_1),.in1(Block4_2),.in2(Block4_3),.in3(Block4_4),.out(BLOCK4_OUT));
ROUND_Permutation1 SHIFT1(.in(BLOCK1_OUT),.out(BLOCK1_OKAY));
ROUND_Permutation4 SHIFT4(.in(BLOCK2_OUT),.out(BLOCK2_OKAY));
ROUND_Permutation7 SHIFT7(.in(BLOCK3_OUT),.out(BLOCK3_OKAY));
ROUND_Permutation9 SHIFT9(.in(BLOCK4_OUT),.out(BLOCK4_OKAY));
XOR_LAYER ENDED(.in1(BLOCK1_OKAY),.in2(BLOCK2_OKAY), .in3(BLOCK3_OKAY), .in4(BLOCK4_OKAY),.out(out));
endmodule

//---------------------------------------//
//          ADD ROUND KEY               //
//--------------------------------------//

module ADD_ROUND_KEY(input [63:0] in,
                     input [79:0] key,
                     output [63:0] out);
assign out = key[63:0]^in;
endmodule


//---------------------------------------//
//          SBOX_Layer_64to4            //
//--------------------------------------//
module SBOX_Layer_64to4(input[63:0] in,
                        output [3:0] S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15,S16);             
assign S1 = in[3:0];
assign S2 = in[7:4];
assign S3 = in[11:8];
assign S4 = in[15:12];
assign S5 = in[19:16];
assign S6 = in[23:20];
assign S7 = in[27:24];
assign S8 = in[31:28];
assign S9 = in[35:32];
assign S10 = in[39:36];
assign S11 = in[43:40];
assign S12 = in[47:44];
assign S13 = in[51:48];
assign S14 = in[55:52];
assign S15 = in[59:56];
assign S16  = in[63:60];
endmodule

//---------------------------------------//
//          SBOX_Layer                  //
//--------------------------------------//
module SBOX_LAYER(
input [3:0] in,
output [3:0] out

);
assign out[0] = (!in[3]&!in[2]&in[1]) || (!in[2]&in[1]&in[0]) | (!in[3]&in[2]&!in[1]) | (in[2]&!in[1]&in[0]) | (in[3]&!in[2]&!in[1]&!in[0]) | (in[3]&in[2]&in[1]&!in[0]);
assign out[1] = (!in[3]&!in[2]&!in[0]) | (!in[3]&!in[1]&!in[0]) | (in[2]&in[1]&in[0])| (in[3]&!in[2]&in[0]) | (in[3]&in[2]&in[1]);
assign out[2] =(!in[3]&!in[2]&!in[1]) | (!in[2]&!in[1]&!in[0]) | (!in[3]&in[2]&!in[0]) | (in[3]&in[1]&in[0]) | (in[3]&in[2]&in[0]);
assign out[3] =(!in[3]&!in[2]&!in[0]) | (!in[3]&in[1]&!in[0]) | (!in[3]&in[2]&in[0]) | (in[3]&!in[1]&!in[0]) | (in[3]&!in[2]&in[1]&in[0]);
endmodule

//---------------------------------------//
//          Block Shuffle               //
//--------------------------------------//
module BLOCK_SHUFFLE(
input [3:0] in0,in1,in2,in3,
output [15:0] out);
wire [3:0] P0,P1,P2,P3;
assign P0 = in0[3:0];
assign P1 = in1[3:0];
assign P2 = in2[3:0];
assign P3 = in3[3:0];
assign out[3:0] = P2;
assign out[7:4] = P3;
assign out[11:8] = P0;
assign out[15:12] = P1;
endmodule

//---------------------------------------//
//          Round Permutation            //
//--------------------------------------//


module ROUND_Permutation1(input [15:0] in,
                         output [15:0] out);
                         wire [15:0] Block1;
                                    assign Block1 = in[15:0];
                                    assign out[0] = Block1[15];
                                    assign out[15:1] = Block1[14:0];
endmodule

//-//
module ROUND_Permutation4(input [15:0] in,
                         output [15:0] out);
wire [15:0] Block2;
assign Block2 = in[15:0];
assign out[3:0] = Block2[15:12];
assign out[15:4] = Block2[11:0];
endmodule


//-//
module ROUND_Permutation7(input [15:0] in,
                         output [15:0] out);
wire [15:0] Block3;
assign Block3 = in[15:0];
assign out[6:0] = Block3[15:9];
assign out[15:7] = Block3[8:0];
endmodule
module ROUND_Permutation9(input [15:0] in,
                         output [15:0] out);
wire [15:0] Block4;
assign Block4 = in[15:0];
assign out[8:0] = Block4[15:7];
assign out[15:9] = Block4[6:0];
endmodule

//---------------------------------------//
//                  XOR                 //
//--------------------------------------//

module XOR_LAYER(input [15:0] in1,in2,in3,in4,
                 output [63:0] out);
assign out[15:0] = in4^in2^in1;
assign out[31:16] = in4^in2;
assign out[47:32] = in3^in1;
assign out[63:48] = in4^in3^in1;
                 endmodule
                 
                 
module KEY_SCHEDULE (input[79:0] key,
                    input [4:0] rcounter,
                    output [79:0] key_out);

wire[79:0] key_memory;

assign key_memory[12:0] = key[79:67];
assign key_memory[79:13] = key[66:0];


assign key_out[0] = (!key_memory[3]&!key_memory[2]&key_memory[1]) || (!key_memory[2]&key_memory[1]&key_memory[0]) | (!key_memory[3]&key_memory[2]&!key_memory[1]) | (key_memory[2]&!key_memory[1]&key_memory[0]) | (key_memory[3]&!key_memory[2]&!key_memory[1]&!key_memory[0]) | (key_memory[3]&key_memory[2]&key_memory[1]&!key_memory[0]);
assign key_out[1] = (!key_memory[3]&!key_memory[2]&!key_memory[0]) | (!key_memory[3]&!key_memory[1]&!key_memory[0]) | (key_memory[2]&key_memory[1]&key_memory[0])| (key_memory[3]&!key_memory[2]&key_memory[0]) | (key_memory[3]&key_memory[2]&key_memory[1]);
assign key_out[2] =(!key_memory[3]&!key_memory[2]&!key_memory[1]) | (!key_memory[2]&!key_memory[1]&!key_memory[0]) | (!key_memory[3]&key_memory[2]&!key_memory[0]) | (key_memory[3]&key_memory[1]&key_memory[0]) | (key_memory[3]&key_memory[2]&key_memory[0]);
assign key_out[3] =(!key_memory[3]&!key_memory[2]&!key_memory[0]) | (!key_memory[3]&key_memory[1]&!key_memory[0]) | (!key_memory[3]&key_memory[2]&key_memory[0]) | (key_memory[3]&!key_memory[1]&!key_memory[0]) | (key_memory[3]&!key_memory[2]&key_memory[1]&key_memory[0]);
assign key_out[63:59] = key_memory[63:59]^rcounter;
assign key_out[79:64] = key_memory[79:64];
assign key_out[58:4] = key_memory[58:4];
endmodule
                