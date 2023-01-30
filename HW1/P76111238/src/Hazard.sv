module Hazard (
    input [1:0]branchctrl,
    input [4:0]rd_addr,
    input memread,
    input [4:0]rs1_addr,
    input [4:0]rs2_addr,
    output reg ctrlflush,
    output reg ifid_regwrite,
    output reg insflush,
    output reg PCWrite,
    output reg [1:0]csrminus
);
    always_comb begin 
        if(branchctrl != 2'b00) begin
            ctrlflush = 1'b1;
            ifid_regwrite = 1'b1;
            insflush = 1'b1;
            PCWrite = 1'b1;
            csrminus = 2'b10;
        end
        else if (memread==1'b1 && (rd_addr==rs1_addr||rd_addr==rs2_addr))begin //load-use data hazard
            ctrlflush = 1'b1;
            ifid_regwrite = 1'b0;
            insflush = 1'b0;
            PCWrite = 1'b0;
            csrminus = 2'b01;
        end
        else begin
            ctrlflush = 1'b0;
            ifid_regwrite = 1'b1;
            insflush = 1'b0;
            PCWrite = 1'b1;
            csrminus = 2'b00;
        end
    end
endmodule









