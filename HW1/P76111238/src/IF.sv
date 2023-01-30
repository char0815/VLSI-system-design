`include "ProgramCounter.sv"

module IF (
    input clk,
    input rst,
    input [1:0] branchctrl,
    input [31:0]pc_immrs1,
    input [31:0]pc_imm,
    input insflush,
    input ifid_regwrite,
    input PCWrite,
    input [31:0]instr_out,

    output reg [31:0]ifpc_out,
    output reg [31:0]ifins_out,
    output reg[31:0]pc_out
);
    reg [31:0] pc_in;
    reg [31:0] wire_pc_out;
    reg [31:0] pc;
    
    assign pc_out = wire_pc_out;
    assign pc = wire_pc_out+32'd4;

    always_comb begin 
        case (branchctrl)
        2'b00: pc_in=pc;
        2'b01: pc_in=pc_imm;
        default: pc_in=pc_immrs1;
        endcase
    end

    ProgramCounter ProgramCounter(
        .clk(clk),
        .rst(rst),
        .pc_in(pc_in),
        .PCWrite(PCWrite),
        .pc_out(wire_pc_out)
    );
    
    always @(posedge clk,posedge rst) begin
        if(rst) begin
            ifpc_out <= 32'd0;
            ifins_out <= 32'd0;
        end
        else begin
            if(ifid_regwrite)begin
                ifpc_out <= wire_pc_out;
                if(insflush)
                    ifins_out <= 32'd0;
                else
                    ifins_out <= instr_out;
            end
        end
    end

endmodule









