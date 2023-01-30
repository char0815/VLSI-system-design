module ControlUnit (
    input [6:0]opcode,
    input [2:0]func3,
    output reg [2:0]ALUop,
    output reg pctoreg,
    output reg ALUsrc,
    output reg [1:0]RDsrc,
    output reg memtoreg,
    output reg memwrite,
    output reg memread,
    output reg regwrite,
    output reg [2:0]Immtype,
    output reg [1:0]branch//branch&jump

);
    localparam [2:0] R_type     = 3'b000,
                     I_type     = 3'b001,
                     ADD_type   = 3'b010,
                     JALR_type  = 3'b011,
                     B_type     = 3'b100,
                     LUI_type   = 3'b101,
                     CSR_type   = 3'b110;
    
    always_comb begin 
        case (opcode)
            7'b0110011: begin
                ALUop = R_type;//rtype
                pctoreg = 1'b0;
                ALUsrc = 1'b1;
                RDsrc = 2'b00;
                memtoreg = 1'b1;
                memwrite = 1'b0;
                memread = 1'b0;
                regwrite = 1'b1;
                Immtype = 3'b000;//dcare
                branch = 2'b00;
            end
            7'b0000011: begin
                ALUop = ADD_type;//lw
                pctoreg = 1'b0;
                ALUsrc = 1'b0;
                RDsrc = 2'b00;//dcare
                memtoreg = 1'b0;
                memwrite = 1'b0;
                memread = 1'b1;
                regwrite = 1'b1;
                Immtype = 3'b001;
                branch = 2'b00;
            end
            7'b0010011: begin//itype
                ALUop = I_type;
                pctoreg = 1'b0;
                ALUsrc = 1'b0;
                RDsrc = 2'b00;
                memtoreg = 1'b1;
                memwrite = 1'b0;
                memread = 1'b0;
                regwrite = 1'b1;
                Immtype = 3'b001;
                branch = 2'b00;
            end
            7'b1100111: begin
                ALUop = JALR_type;//jalr
                pctoreg = 1'b0;
                ALUsrc = 1'b0;
                RDsrc = 2'b01;
                memtoreg = 1'b1;
                memwrite = 1'b0;
                memread = 1'b0;
                regwrite = 1'b1;
                Immtype = 3'b001;
                branch = 2'b10;
            end
            7'b0100011: begin
                ALUop = ADD_type;//sw
                pctoreg = 1'b0;
                ALUsrc = 1'b0;
                RDsrc = 2'b00;
                memtoreg = 1'b1;//dcare
                memwrite = 1'b1;
                memread = 1'b0;
                regwrite = 1'b0;
                Immtype = 3'b010;
                branch = 2'b00;
            end
            7'b1100011: begin
                ALUop = B_type;//branch
                pctoreg = 1'b0;
                ALUsrc = 1'b1;
                RDsrc = 2'b00;
                memtoreg = 1'b0;
                memwrite = 1'b0;
                memread = 1'b0;
                regwrite = 1'b0;
                Immtype = 3'b011;
                branch = 2'b01;
            end
            7'b0010111: begin
                ALUop = ADD_type;//U AUIPC
                pctoreg = 1'b1;
                ALUsrc = 1'b0;//dcare
                RDsrc = 2'b01;
                memtoreg = 1'b1;
                memwrite = 1'b0;
                memread = 1'b0;
                regwrite = 1'b1;
                Immtype = 3'b100;
                branch = 2'b00;
            end
            7'b0110111: begin
                ALUop = LUI_type;//U LUI
                pctoreg = 1'b0;//dcare
                ALUsrc = 1'b0;
                RDsrc = 2'b00;
                memtoreg = 1'b1;
                memwrite = 1'b0;
                memread = 1'b0;
                regwrite = 1'b1;
                Immtype = 3'b100;
                branch = 2'b00;
            end
            7'b1101111: begin
                ALUop = ADD_type;//j-type
                pctoreg = 1'b0;
                ALUsrc = 1'b0;//dcare
                RDsrc = 2'b01;
                memtoreg = 1'b1;
                memwrite = 1'b0;
                memread = 1'b0;
                regwrite = 1'b1;
                Immtype = 3'b101;
                branch = 2'b11;
            end
            7'b1110011: begin
                ALUop = CSR_type;//csr-type
                pctoreg = 1'b0;
                if(func3[2]==1'b1) ALUsrc = 1'b0;
                else ALUsrc = 1'b1;
                RDsrc = 2'b10;
                memtoreg = 1'b1;
                memwrite = 1'b0;
                memread = 1'b0;
                regwrite = 1'b1;
                Immtype = 3'b001;//itype
                branch = 2'b00;
            end
            default: begin
                ALUop = 3'b0;
                pctoreg = 1'b0;
                ALUsrc = 1'b0;
                RDsrc = 2'b00;
                memtoreg = 1'b0;
                memwrite = 1'b0;
                memread = 1'b0;
                regwrite = 1'b0;
                Immtype = 3'b000;
                branch = 2'b00;
            end
        endcase
    end
    
endmodule









