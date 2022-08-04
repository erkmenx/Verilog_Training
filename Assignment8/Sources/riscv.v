
module ALU(
           input [31:0] A,
           input [31:0] B,
           input [2:0] sel,
           output reg [31:0] out,
           output V,
           output C,
           output Neg,
           output Zero);     
// ARITHMETIC           
localparam ADD = 3'b100;
localparam SUB = 3'b101;
localparam LOADUI = 3'b110;
localparam ADDUI = 3'b111;
// LOGICAL
localparam AND = 3'b000;
localparam OR = 3'b001;
localparam XOR = 3'b010;
localparam NOT = 3'b011;
assign Zero = (out==0);
assign V = ((A+B)>=32'hFFFFFFFF);
assign C = ((A+B)>=32'hFFFFFFFF);
assign Neg = ((A>B) && (sel == 3'b101));

always @(A,B,sel) begin

    case(sel)
        
        AND: out = A&B;
        OR: out = A|B;
        XOR: out = A^B;
        NOT: out = ~A;
        
        ADD: out = A+B;
        SUB: out = A-B;
        LOADUI: out = A;
        ADDUI: out = A; 
    endcase

end 
endmodule


module testingproject(

input [31:0] B,
input [4:0] S,          // Selection
input T,               // Shifting Left/Right               
output reg [31:0] out    );

localparam LEFT = 1'b0;         /// Shift LEFT when T = 0
localparam RIGHT = 1'b1;        /// Shift RIGHT when T = 1
localparam NOROTATION = 5'd0;
localparam SHIFT1 = 5'd1;
localparam SHIFT2 = 5'd2;
localparam SHIFT3 = 5'd3;
localparam SHIFT4 = 5'd4;
localparam SHIFT5 = 5'd5;
localparam SHIFT6 = 5'd6;
localparam SHIFT7 = 5'd7;
localparam SHIFT8 = 5'd8;
localparam SHIFT9 = 5'd9;
localparam SHIFT10 = 5'd10;
localparam SHIFT11 = 5'd11;
localparam SHIFT12 = 5'd12;
localparam SHIFT13 = 5'd13;
localparam SHIFT14 = 5'd14;
localparam SHIFT15 = 5'd15;
localparam SHIFT16 = 5'd16;
localparam SHIFT17 = 5'd17;
localparam SHIFT18 = 5'd18;
localparam SHIFT19 = 5'd19;
localparam SHIFT20 = 5'd20;
localparam SHIFT21 = 5'd21;
localparam SHIFT22 = 5'd22;
localparam SHIFT23 = 5'd23;
localparam SHIFT24 = 5'd24;
localparam SHIFT25 = 5'd25;
localparam SHIFT26 = 5'd26;
localparam SHIFT27 = 5'd27;
localparam SHIFT28 = 5'd28;
localparam SHIFT29 = 5'd29;
localparam SHIFT30 = 5'd30;
localparam SHIFT31 = 5'd31;



always @(B,S,T) begin




case(S)
    
    NOROTATION: out = B;
    SHIFT1:
        case(T)
            LEFT:
            begin
            out[0]=B[31];
            out[31:1] = B[30:0];
            end
            RIGHT:
            begin
            out[31] = B[0];
            out[30:0] = B[31:1];
            end
         endcase
    SHIFT2:
            case(T)
            LEFT:
            begin
            out[1:0]=B[31:30];
            out[31:2] = B[29:0];
            end
            RIGHT:
            begin
            out[31:30] = B[1:0];
            out[29:0] = B[31:2];
            end
         endcase
    SHIFT3:
            case(T)
            LEFT:
            begin
            out[2:0]=B[31:29];
            out[31:3] = B[28:0];
            end
            RIGHT:
            begin
            out[31:29] = B[2:0];
            out[28:0] = B[31:3];
            end
         endcase
    SHIFT4:
            case(T)
            LEFT:
            begin
            out[3:0]=B[31:28];
            out[31:4] = B[27:0];
            end
            RIGHT:
            begin
            out[31:28] = B[3:0];
            out[27:0] = B[31:4];
            end
         endcase
    SHIFT5:
            case(T)
            LEFT:
            begin
            out[4:0]=B[31:27];
            out[31:5] = B[26:0];
            end
            RIGHT:
            begin
            out[31:27] = B[4:0];
            out[26:0] = B[31:5];
            end
         endcase
    SHIFT6:
            case(T)
            LEFT:
            begin
            out[5:0]=B[31:26];
            out[31:6] = B[25:0];
            end
            RIGHT:
            begin
            out[31:26] = B[5:0];
            out[25:0] = B[31:6];
            end
         endcase
    SHIFT7:
            case(T)
            LEFT:
            begin
            out[6:0]=B[31:25];
            out[31:7] = B[24:0];
            end
            RIGHT:
            begin
            out[31:25] = B[6:0];
            out[24:0] = B[31:7];
            end
         endcase
    SHIFT8:
            case(T)
            LEFT:
            begin
            out[7:0]=B[31:24];
            out[31:8] = B[23:0];
            end
            RIGHT:
            begin
            out[31:24] = B[7:0];
            out[23:0] = B[31:8];
            end
         endcase
    SHIFT9:
            case(T)
            LEFT:
            begin
            out[8:0]=B[31:23];
            out[31:9] = B[22:0];
            end
            RIGHT:
            begin
            out[31:23] = B[8:0];
            out[22:0] = B[31:9];
            end
         endcase
    SHIFT10:
            case(T)
            LEFT:
            begin
            out[9:0]=B[31:22];
            out[31:10] = B[21:0];
            end
            RIGHT:
            begin
            out[31:22] = B[9:0];
            out[21:0] = B[31:10];
            end
         endcase
    SHIFT11:
            case(T)
            LEFT:
            begin
            out[10:0]=B[31:21];
            out[31:11] = B[20:0];
            end
            RIGHT:
            begin
            out[31:21] = B[10:0];
            out[20:0] = B[31:11];
            end
         endcase
    SHIFT12:
            case(T)
            LEFT:
            begin
            out[11:0]=B[31:20];
            out[31:12] = B[19:0];
            end
            RIGHT:
            begin
            out[31:20] = B[11:0];
            out[19:0] = B[31:12];
            end
         endcase
    SHIFT13:
            case(T)
            LEFT:
            begin
            out[12:0]=B[31:19];
            out[31:13] = B[18:0];
            end
            RIGHT:
            begin
            out[31:19] = B[12:0];
            out[18:0] = B[31:13];
            end
         endcase
    SHIFT14:
            case(T)
            LEFT:
            begin
            out[13:0]=B[31:18];
            out[31:14] = B[17:0];
            end
            RIGHT:
            begin
            out[31:18] = B[13:0];
            out[17:0] = B[31:14];
            end
         endcase
    SHIFT15:
            case(T)
            LEFT:
            begin
            out[14:0]=B[31:17];
            out[31:15] = B[16:0];
            end
            RIGHT:
            begin
            out[31:17] = B[14:0];
            out[16:0] = B[31:15];
            end
         endcase
    SHIFT16:
            case(T)
            LEFT:
            begin
            out[15:0]=B[31:16];
            out[31:16] = B[15:0];
            end
            RIGHT:
            begin
            out[31:16] = B[15:0];
            out[15:0] = B[31:16];
            end
         endcase
    SHIFT17:            // LEFT HERE
            case(T)
            LEFT:
            begin
            out[16:0]=B[31:15];
            out[31:17] = B[14:0];
            end
            RIGHT:
            begin
            out[31:15] = B[16:0];
            out[14:0] = B[31:15];
            end
         endcase
    SHIFT18:
            case(T)
            LEFT:
            begin
            out[17:0]=B[31:14];
            out[31:18] = B[13:0];
            end
            RIGHT:
            begin
            out[31:14] = B[17:0];
            out[13:0] = B[31:18];
            end
         endcase
    SHIFT19:
            case(T)
            LEFT:
            begin
            out[18:0]=B[31:13];
            out[31:19] = B[12:0];
            end
            RIGHT:
            begin
            out[31:13] = B[18:0];
            out[12:0] = B[31:19];
            end
         endcase
    SHIFT20:
            case(T)
            LEFT:
            begin
            out[19:0]=B[31:12];
            out[31:20] = B[11:0];
            end
            RIGHT:
            begin
            out[31:12] = B[19:0];
            out[19:0] = B[31:20];
            end
         endcase
    SHIFT21:
            case(T)
            LEFT:
            begin
            out[20:0]=B[31:11];
            out[31:21] = B[10:0];
            end
            RIGHT:
            begin
            out[31:11] = B[20:0];
            out[10:0] = B[31:21];
            end
         endcase
    SHIFT22:
            case(T)
            LEFT:
            begin
            out[21:0]=B[31:10];
            out[31:22] = B[9:0];
            end
            RIGHT:
            begin
            out[31:10] = B[21:0];
            out[9:0] = B[31:22];
            end
         endcase
    SHIFT23:
            case(T)
            LEFT:
            begin
            out[22:0] = B[31:9];
            out[31:23] = B[8:0];
            end
            RIGHT:
            begin
            out[31:9] = B[22:0];
            out[8:0] = B[31:23];
            end
         endcase
    SHIFT24:
            case(T)
            LEFT:
            begin
            out[23:0]=B[31:8];
            out[31:24] = B[7:0];
            end
            RIGHT:
            begin
            out[31:8] = B[23:0];
            out[7:0] = B[31:24];
            end
         endcase
    SHIFT25:
            case(T)
            LEFT:
            begin
            out[24:0]=B[31:7];
            out[31:25] = B[6:0];
            end
            RIGHT:
            begin
            out[31:7] = B[24:0];
            out[6:0] = B[31:25];
            end
         endcase
    SHIFT26:
            case(T)
            LEFT:
            begin
            out[25:0]=B[31:6];
            out[31:26] = B[5:0];
            end
            RIGHT:
            begin
            out[31:6] = B[25:0];
            out[5:0] = B[31:26];
            end
         endcase
    SHIFT27:
            case(T)
            LEFT:
            begin
            out[26:0]=B[31:5];
            out[31:27] = B[4:0];
            end
            RIGHT:
            begin
            out[31:5] = B[26:0];
            out[4:0] = B[31:27];
            end
         endcase
    SHIFT28:
            case(T)
            LEFT:
            begin
            out[27:0]=B[31:4];
            out[31:28] = B[3:0];
            end
            RIGHT:
            begin
            out[31:4] = B[27:0];
            out[3:0] = B[31:28];
            end
         endcase
    SHIFT29:
            case(T)
            LEFT:
            begin
            out[28:0]=B[31:3];
            out[31:28] = B[2:0];
            end
            RIGHT:
            begin
            out[31:3] = B[28:0];
            out[2:0] = B[31:28];
            end
         endcase
    SHIFT30:
            case(T)
            LEFT:
            begin
            out[29:0]=B[31:2];
            out[31:30] = B[1:0];
            end
            RIGHT:
            begin
            out[31:2] = B[29:0];
            out[1:0] = B[31:30];
            end
         endcase
    SHIFT31:
            case(T)
            LEFT:
            begin
            out[30:0]=B[31:1];
            out[31] = B[0];
            end
            RIGHT:
            begin
            out[31:1] = B[30:0];
            out[0] = B[31];
            end
            endcase

endcase
end
endmodule



