module Branch (
    input zeroFlag,
    //input ALUout,
    input [1:0]branch,
    //input [2:0]func3,
    output reg [1:0]branchctrl
);
    always_comb begin 
        case (branch)
            2'b01: begin
                if(zeroFlag) branchctrl =2'b01;
                else branchctrl =2'b00;
            end
            2'b10: branchctrl =2'b10;
            2'b11: branchctrl =2'b01;
            default: branchctrl =2'b00;
        endcase
    end
endmodule












