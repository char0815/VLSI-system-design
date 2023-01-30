module csr (
    /* input rden,
    input csren, */
    input [31:0]imm,
    input [31:0]rs1_data,
    input [2:0]func3,
    input [63:0]cycle,
    input [63:0]instr,
    output reg [31:0]csr_out 
);
    logic [63:0]instr_wire;
    always_comb begin
    instr_wire = instr - 64'd2;
    case (func3)
        3'b001: csr_out = 32'b0;
        3'b010: begin
            case (imm[11:0])
                12'b110010000010: csr_out = instr_wire[63:32];
                12'b110000000010: csr_out = instr_wire[31:0];
                12'b110010000000: csr_out = cycle[63:32];
                12'b110000000000: csr_out = cycle[31:0];
                default: csr_out = 32'b0;
            endcase
        end
        3'b011: csr_out = 32'b0;
        3'b101: csr_out = 32'b0;
        3'b110: csr_out = 32'b0;
        3'b111: csr_out = 32'b0;
        default: csr_out = 32'b0;
    endcase
    end
endmodule








