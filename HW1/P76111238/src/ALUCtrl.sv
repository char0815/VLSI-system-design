module ALUCtrl (
    input [6:0]func7,
    input [2:0]func3,
    input [2:0]ALUOP,
    output reg [4:0]ALUCtrl
);
    localparam [2:0] R_type     = 3'b000,
                     I_type     = 3'b001,
                     ADD_type   = 3'b010,
                     JALR_type  = 3'b011,
                     B_type     = 3'b100,
                     LUI_type   = 3'b101,
                     CSR_type   = 3'b110;

    always_comb begin 
        case (ALUOP)
            R_type: begin
                case (func3)
                    3'b000: begin
                        if(func7) ALUCtrl = 5'b00001;
                        else ALUCtrl = 5'b00000;
                    end
                    3'b001: begin
                        ALUCtrl = 5'b00010;
                    end
                    3'b010: begin
                        ALUCtrl = 5'b01000;
                    end
                    3'b011: begin
                        ALUCtrl = 5'b01001;
                    end
                    3'b100: begin
                        ALUCtrl = 5'b00011;
                    end
                    3'b101: begin
                        if(func7) ALUCtrl = 5'b00100;
                        else ALUCtrl = 5'b00110;
                    end
                    3'b110: begin
                        ALUCtrl = 5'b00101;
                    end
                    3'b111: begin
                        ALUCtrl = 5'b00111;
                    end 
                endcase

            end
            I_type: begin
                case (func3)
                    3'b000: begin
                        ALUCtrl = 5'b00000;
                    end
                    3'b001: begin
                        ALUCtrl = 5'b00010;
                    end
                    3'b010: begin
                        ALUCtrl = 5'b01000;
                    end
                    3'b011: begin
                        ALUCtrl = 5'b01001;
                    end
                    3'b100: begin
                        ALUCtrl = 5'b00011;
                    end
                    3'b101: begin
                        if(func7) ALUCtrl = 5'b00100;
                        else ALUCtrl = 5'b00110;
                    end
                    3'b110: begin
                        ALUCtrl = 5'b00101;
                    end
                    3'b111: begin
                        ALUCtrl = 5'b00111;
                    end 
                endcase
            end
            ADD_type: begin
                case (func3)
                    3'b000: ALUCtrl = 5'b00000;
                    3'b001: ALUCtrl = 5'b00000;
                    3'b010: ALUCtrl = 5'b00000;
                    3'b100: ALUCtrl = 5'b00000;
                    3'b101: ALUCtrl = 5'b00000;
                    default: ALUCtrl = 5'b11111;//output=0
                endcase
            end
            JALR_type: begin
                case (func3)
                    3'b000: ALUCtrl = 5'b10001;
                    default: ALUCtrl = 5'b11111;//output=0
                endcase
            end
            B_type: begin
                case (func3)
                    3'b000: ALUCtrl = 5'b01011;
                    3'b001: ALUCtrl = 5'b01100;
                    3'b100: ALUCtrl = 5'b01101;
                    3'b101: ALUCtrl = 5'b01111;
                    3'b110: ALUCtrl = 5'b01110;
                    3'b111: ALUCtrl = 5'b10000;
                    default: ALUCtrl = 5'b11111;//output=0
                endcase
            end
            LUI_type: begin
                ALUCtrl = 5'b01010;
            end
            default: 
                ALUCtrl = 5'b11111;//output=0
        endcase
    end
    
endmodule















