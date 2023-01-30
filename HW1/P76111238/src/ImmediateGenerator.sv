module ImmediateGenerator (
    input [2:0]Immtype,
    input [31:0]imm_in,
    output reg [31:0]imm_out
);
    
    always_comb begin 
        case (Immtype)
            3'b001://itype
            begin
                imm_out = {{20{imm_in[31]}},imm_in[31:20]};
            end
            3'b010://stype
            begin
                imm_out = {{20{imm_in[31]}},imm_in[31:25],imm_in[11:7]};
            end
            3'b011://btype
            begin
                imm_out = {{19{imm_in[31]}},{imm_in[31]},{imm_in[7]},imm_in[30:25],imm_in[11:8],1'b0};
            end 
            3'b100://utype
            begin
                imm_out = {imm_in[31:12], 12'b0};
            end 
            3'b101://jtype
            begin
                imm_out = {{11{imm_in[31]}},{imm_in[31]},imm_in[19:12],{imm_in[20]},imm_in[30:21],1'b0};
            end 
            default: begin
                imm_out = 32'd0;
            end
        endcase
    end
endmodule









