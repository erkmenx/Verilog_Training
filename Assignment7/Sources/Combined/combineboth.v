

module combineboth( input clk,
                    input [79:0] master_key,
                    input [63:0] plain_text,
                    input rst,
                    input start,
                    output [63:0] out,
                    output ended

    );
    wire done;
    wire [63:0] cipher_text;
decryption DUT (.clk(clk),.start(done),.ciphertext(cipher_text),.key_in(master_key),.done(ended),.message(out));
question1_c DUT2 (.clk(clk),.plain_text(plain_text),.master_key(master_key),.rst(rst),.start(start),.out(cipher_text),.done(done));
endmodule
