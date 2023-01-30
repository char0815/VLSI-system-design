module ALU (
    input [4:0]ALUCtrl,
    input [31:0]in1,
    input [31:0]in2,
    output reg zeroFlag,
    output reg [31:0]ALUout
);
    wire signed [31:0] signed_in1;
    wire signed [31:0] signed_in2;

    assign signed_in1 = in1;
    assign signed_in2 = in2;

    always_comb begin 
        case (ALUCtrl)
            5'b00000: begin//add
                ALUout = in1 + in2;
            end
            5'b00001: begin//sub
                ALUout = in1 - in2;
            end
            5'b00010: begin//<<(unsign)
                ALUout = in1<<in2[4:0];
            end
            5'b00011: begin//^
                ALUout = in1 ^ in2;
            end
            5'b00100: begin//>>>(sign)
                ALUout = signed_in1 >>> in2[4:0]; 
            end
            5'b00101: begin//or
                ALUout = in1 | in2;
            end
            5'b00110: begin//>>(unsign)
                ALUout = in1 >> in2[4:0];
            end
            5'b00111: begin//and
                ALUout = in1 & in2;
            end
            5'b01000: begin//slt
                ALUout = (signed_in1 < signed_in2)?32'b1:32'b0;
            end
            5'b01001: begin//sltu
                ALUout = (in1 < in2)? 32'b1:32'b0;
            end
            5'b01010: begin//imm
                ALUout = in2;
            end
            5'b10001: begin//jalr
                ALUout = in1 + in2;
                ALUout[0] = 1'b0;
            end
            default: 
                ALUout = 32'b0;
        endcase
    end
    always_comb begin 
        case (ALUCtrl)
            5'b01011: begin
                zeroFlag = (in1 == in2)?1'b1:1'b0;
            end
            5'b01100: begin
                zeroFlag = (in1 != in2)?1'b1:1'b0;
            end
            5'b01101: begin
                zeroFlag = (signed_in1 < signed_in2)?1'b1:1'b0;
            end
            5'b01110: begin
                zeroFlag = (in1 < in2)?1'b1:1'b0;
            end
            5'b01111: begin
                zeroFlag = (signed_in1 >= signed_in2)?1'b1:1'b0;
            end
            5'b10000: begin
                zeroFlag = (in1 >= in2)?1'b1:1'b0;
            end 
            default:
                zeroFlag = 1'b0; 
        endcase
    end

endmodule




