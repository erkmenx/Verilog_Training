module decryption(input clk,
                  input start,
                  input[63:0] ciphertext,
                  input [79:0] key_in,
                  output reg done,
                  output reg [63:0] message);
reg startdecryption;
reg [4:0] rcounter; 
reg [63:0] ciphertext_new;
reg [63:0] ciphertext_1st;
wire [63:0] plain_text;
wire [79:0] key;
wire [79:0] new_key;
reg [79:0] neededkey;
reg [79:0] schedulekey;
round o7 (.ciphertext(ciphertext_new),.key_in(neededkey),.out(plain_text));
KEY_SCHEDULE p7 (.key(schedulekey),.rcounter(rcounter),.key_out(new_key));
KEY_FINDER l7 (.key(neededkey),.rcounter(rcounter),.key_output(key));


always @(posedge clk) begin

if(!start)
    begin
        done <= 0;
        schedulekey <= key_in;
        ciphertext_new <= ciphertext;
        startdecryption <= 0;
        rcounter <=0;
    end
else
    begin
        if(!done)
            begin
                 // KEY SCHEDULE
                if(0<=rcounter<=24 && !startdecryption)
                    begin
                    schedulekey <= new_key;
                    rcounter <= rcounter+1;
                          if(rcounter == 24)
                            begin
                                neededkey <= new_key;
                                startdecryption<=1;
                                rcounter<=5'd24;
                            end
                            

                 
                    end 
                    
                    // KEY FIND
                    
                    if(0<=rcounter<=24 && startdecryption || rcounter==31)
                        begin
                            neededkey<=key;
                        if(rcounter == 24)
                                    begin
                                        ciphertext_new <= neededkey ^ ciphertext;            
                                    end
                         else
                         ciphertext_new <=plain_text;
                          if(rcounter==31)
                        begin
                        message<=plain_text;
                        done <=1;
                        end
                         rcounter<=rcounter-1;
                        end
            end
    
    end

end




endmodule


module round(input[63:0] ciphertext,
             input[63:0] key_in,
             output [63:0] out);
wire [3:0] Block1_1,Block1_2,Block1_3,Block1_4;
wire [3:0] Block2_1,Block2_2,Block2_3,Block2_4;
wire [3:0] Block3_1,Block3_2,Block3_3,Block3_4;
wire [3:0] Block4_1,Block4_2,Block4_3,Block4_4;            
wire [15:0] BLOCK1_OUT,BLOCK1_OKAY;
wire [15:0] BLOCK2_OUT,BLOCK2_OKAY;
wire [15:0] BLOCK3_OUT,BLOCK3_OKAY;
wire [15:0] BLOCK4_OUT,BLOCK4_OKAY;
wire [3:0] S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15,S16;
wire [63:0] step1;
NOT_XOR_LAYER s1(.in(ciphertext),.out1(BLOCK1_OUT),.out2(BLOCK2_OUT),.out3(BLOCK3_OUT),.out4(BLOCK4_OUT));
ROUND_Permutation9 s2_4(.in(BLOCK4_OUT),.out(BLOCK4_OKAY));
ROUND_Permutation7 s2_3(.in(BLOCK3_OUT),.out(BLOCK3_OKAY));
ROUND_Permutation4 s2_2(.in(BLOCK2_OUT),.out(BLOCK2_OKAY));
ROUND_Permutation1 s2_1(.in(BLOCK1_OUT),.out(BLOCK1_OKAY));
BLOCK_SHUFFLE s3_4(.in(BLOCK4_OKAY),.out0(Block4_1),.out1(Block4_2),.out2(Block4_3),.out3(Block4_4));
BLOCK_SHUFFLE s3_3(.in(BLOCK3_OKAY),.out0(Block3_1),.out1(Block3_2),.out2(Block3_3),.out3(Block3_4));
BLOCK_SHUFFLE s3_2(.in(BLOCK2_OKAY),.out0(Block2_1),.out1(Block2_2),.out2(Block2_3),.out3(Block2_4));
BLOCK_SHUFFLE s3_1(.in(BLOCK1_OKAY),.out0(Block1_1),.out1(Block1_2),.out2(Block1_3),.out3(Block1_4));
SBOX_LAYER SBOX1_1(.in(Block1_1),.out(S1));
SBOX_LAYER SBOX1_2(.in(Block1_2),.out(S2));
SBOX_LAYER SBOX1_3(.in(Block1_3),.out(S3));
SBOX_LAYER SBOX1_4(.in(Block1_4),.out(S4));
SBOX_LAYER SBOX2_1(.in(Block2_1),.out(S5));
SBOX_LAYER SBOX2_2(.in(Block2_2),.out(S6));
SBOX_LAYER SBOX2_3(.in(Block2_3),.out(S7));
SBOX_LAYER SBOX2_4(.in(Block2_4),.out(S8));
SBOX_LAYER SBOX3_1(.in(Block3_1),.out(S9));
SBOX_LAYER SBOX3_2(.in(Block3_2),.out(S10));
SBOX_LAYER SBOX3_3(.in(Block3_3),.out(S11));
SBOX_LAYER SBOX3_4(.in(Block3_4),.out(S12));
SBOX_LAYER SBOX4_1(.in(Block4_1),.out(S13));
SBOX_LAYER SBOX4_2(.in(Block4_2),.out(S14));
SBOX_LAYER SBOX4_3(.in(Block4_3),.out(S15));
SBOX_LAYER SBOX4_4(.in(Block4_4),.out(S16));
SBOX_Layer_4to64 s5(.S1(S1),.S2(S2),.S3(S3),.S4(S4),.S5(S5),.S6(S6),.S7(S7),.S8(S8),.S9(S9),.S10(S10),.S11(S11),.S12(S12),.S13(S13),.S14(S14),.S15(S15),.S16(S16),.out(step1));
ADD_ROUND_KEY s6(.in(step1),.key(key_in),.out(out));
endmodule

//---------------------------------------//
//                  XOR                 //
//--------------------------------------//
module NOT_XOR_LAYER(output [15:0] out1,out2,out3,out4,
                 input [63:0] in);
assign out1 = in[31:16]^in[15:0];
assign out2 = in[63:48]^in[47:32]^in[31:16];
assign out3 = in[47:32]^in[31:16]^in[15:0];
assign out4 = in[47:32]^in[63:48];
endmodule                 
//---------------------------------------//
//                 SBOX                 //
//--------------------------------------//                 
module SBOX_LAYER(input [3:0] in,
            output [3:0] out);
wire A,B,C,D;
assign A=in[3];
assign B=in[2];
assign C=in[1];
assign D=in[0];
assign out[0] = (!B&!C&D) | (!A&C&!D)|(!B&C&!D) | (!A&B&!C) | (A&B&C&D);
assign out[1] = (!A&!B&!C) | (!A&!B&D) |(A&!B&C) |(A&C&D) | (!A&B&C&!D) | (A&B&!C&!D);
assign out[2] = (!A&C&D) | (!A&B&D) |(!A&B&C)|(A&!B&!C) | (A&!B&!D) | (A&!C&!D);
assign out[3] = (!B&!C&!D) | (!A&!B&C) |(!A&C&!D) | (B&!C&D) | (A&B&D);
endmodule                 


//---------------------------------------//
//          SBOX_Layer_4to64            //
//--------------------------------------//
module SBOX_Layer_4to64(output [63:0] out,
                        input [3:0] S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15,S16);             
assign out[3:0]=S1;
assign out[7:4]=S2;
assign out[11:8]=S3;
assign out[15:12]=S4;
assign out[19:16]=S5;
assign out[23:20]=S6;
assign out[27:24]=S7;
assign out[31:28]=S8;
assign out[35:32]=S9;
assign out[39:36]=S10;
assign out[43:40]=S11;
assign out[47:44]=S12;
assign out[51:48]=S13;
assign out[55:52]=S14;
assign out[59:56]=S15;
assign out[63:60]=S16;
endmodule




//---------------------------------------//
//          Round Permutation            //
//--------------------------------------//
//1//
module ROUND_Permutation1(input [15:0] in,
                         output [15:0] out);
                         wire [15:0] Block1;
                                    assign Block1 = in[15:0];
                                    assign out[15] = Block1[0];
                                    assign out[14:0] = Block1[15:1];
endmodule
//4//
module ROUND_Permutation4(input [15:0] in,
                         output [15:0] out);
wire [15:0] Block2;
assign Block2 = in[15:0];
assign out[15:12] = Block2[3:0];
assign out[11:0] = Block2[15:4];
endmodule
//7//
module ROUND_Permutation7(input [15:0] in,
                         output [15:0] out);
wire [15:0] Block3;
assign Block3 = in[15:0];
assign out[15:9] = Block3[6:0];
assign out[8:0] = Block3[15:7];
endmodule
//9//
module ROUND_Permutation9(input [15:0] in,
                         output [15:0] out);
wire [15:0] Block4;
assign Block4 = in[15:0];
assign out[15:7] = Block4[8:0];
assign out[6:0] = Block4[15:9];
endmodule

//---------------------------------------//
//          Block Shuffle               //
//--------------------------------------//
module BLOCK_SHUFFLE(
input [15:0] in,
output [3:0] out0,out1,out2,out3);
assign out2 = in[3:0];
assign out3 = in[7:4];
assign out0 = in[11:8];
assign out1 = in[15:12];
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
//            KEY SCHEDULE              //
//--------------------------------------//
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

//---------------------------------------//
//            KEY FINDER                 //
//--------------------------------------//   
module KEY_FINDER (input[79:0] key,
                    input [4:0] rcounter,
                    output [79:0] key_output);

wire[79:0] key_memory;
wire A,B,C,D;
assign A = key[3];
assign B = key[2];
assign C = key[1];
assign D = key[0];

assign key_memory[63:59] = key[63:59]^rcounter;
assign key_memory[0] =(!B&!C&D) | (!A&C&!D)|(!B&C&!D) | (!A&B&!C) | (A&B&C&D);  
assign key_memory[1] = (!A&!B&!C) | (!A&!B&D) |(A&!B&C) |(A&C&D) | (!A&B&C&!D) | (A&B&!C&!D);
assign key_memory[2] = (!A&C&D) | (!A&B&D) |(!A&B&C)|(A&!B&!C) | (A&!B&!D) | (A&!C&!D);
assign key_memory[3] = (!B&!C&!D) | (!A&!B&C) |(!A&C&!D) | (B&!C&D) | (A&B&D);
assign key_memory[58:4] = key[58:4];
assign key_memory[79:64] = key[79:64];

assign key_output[79:67] = key_memory[12:0];
assign key_output[66:0] = key_memory[79:13];
endmodule