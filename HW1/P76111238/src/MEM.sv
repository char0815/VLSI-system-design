module MEM (
    input rst,
    input clk,
    input exe_memwrite,
    input exe_regwrite,
    input exe_memread,
    input exe_memtoreg,
    input [1:0]exe_RDsrc,
    input [31:0]mem_dataout_wire,
    input [31:0]ALUout,
    input [31:0]csr_out,
    input [31:0]EX_forward_rs2_data,
    input [4:0]EX_rd_addr,
    input [31:0]exe_pctoreg,
    input [2:0]exe_func3,
    output reg fdmem_regwrite,
    output reg mem_regwrite,
    output reg mem_memtoreg,
    output reg [31:0]mem_rd_data, 
    output reg [4:0]mem_rd_addr,
    output reg [31:0]mem_dataout,
    output reg [31:0]mem_datain,
    output reg [31:0]Forward_memrd_data,
    output reg CS,
    output reg [3:0]WEB
);
    
    assign CS = exe_memread | exe_memwrite;
    always_comb begin
        WEB = 4'b1111;
        if(exe_memwrite) begin
            WEB = 4'b0000;
            /*  case (exe_func3)
                3'b000: // SB
                    WEB[ALUout[1:0]] = 1'b0;
                3'b001: // SH
                    WEB[{ALUout[1],1'b0}+:2] = 2'b00;
                default: // SW
                    WEB = 4'b0000;
            endcase */
        end
    end
    
    always_comb begin 
        if(exe_RDsrc ==2'b01) begin
            Forward_memrd_data = exe_pctoreg;
            mem_datain = 32'b0;            
        end
        else if(exe_RDsrc ==2'b10) begin
            Forward_memrd_data = csr_out; 
            mem_datain = 32'b0;
        end
        else begin
            Forward_memrd_data = ALUout;
            mem_datain = 32'b0;
            case (exe_func3)
                3'b000: begin
                    mem_datain[{ALUout[1:0], 3'b0}+:8] = EX_forward_rs2_data[7:0];
                
                end
                3'b001: begin             
                    mem_datain[{ALUout[1], 4'b0}+:16] = EX_forward_rs2_data[15:0];
   
                end
                default: begin    
                    mem_datain = EX_forward_rs2_data;
                end
            endcase 
        end
    end

    always @(posedge clk,posedge rst) begin
        if(rst) begin
            mem_regwrite <= 1'b0;
            mem_memtoreg <= 1'b0;
            mem_rd_data <= 32'b0;
            mem_rd_addr <= 5'b0;
            mem_dataout <= 32'b0;
            fdmem_regwrite <= 1'b0;
        end
        else begin
            mem_regwrite <= exe_regwrite;
            mem_memtoreg <= exe_memtoreg;
            if(exe_RDsrc ==2'b01) begin
                mem_rd_data <= exe_pctoreg;            
            end
            else if(exe_RDsrc ==2'b10) begin
                mem_rd_data <= csr_out; 
            end
            else begin
                mem_rd_data <= ALUout;
            end

            mem_rd_addr <= EX_rd_addr;
            case (exe_func3)
                3'b010: mem_dataout <= mem_dataout_wire;//LW
                3'b000: mem_dataout <={{24{mem_dataout_wire[7]}},mem_dataout_wire[7:0]};//LB
                3'b001: mem_dataout <={{16{mem_dataout_wire[15]}},mem_dataout_wire[15:0]};//LH
                3'b100: mem_dataout <={24'b0,mem_dataout_wire[7:0]};//LBU
                3'b101: mem_dataout <={16'b0,mem_dataout_wire[15:0]};//LHU
                default: mem_dataout <= 32'b0; 
            endcase
            
            fdmem_regwrite <= exe_regwrite;
        end
    end

endmodule









