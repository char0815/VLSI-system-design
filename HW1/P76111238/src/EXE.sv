`include "ALU.sv"
`include "ALUCtrl.sv"
`include "csr.sv"
module EXE (
    input rst,
    input clk,
    input [1:0]csrminus,
    input [31:0]ID_PC,
    input [31:0]rs1_data,
    input [31:0]rs2_data,
    input [2:0]func3,
    input [6:0]func7,
    input [31:0]imm,
    input [2:0]ALUOP,
    input [4:0]rd_addr,
    input pctoreg,
    input ALUsrc,
    input [1:0]RDsrc,
    input memtoreg,
    input memwrite,
    input memread,
    input regwrite,
    input [1:0]Forward1,
    input [1:0]Forward2,
    input [31:0]Forward_memrd_data,
    input [31:0]Forward_wb_data,
    //input [31:0]csrrd_data,
    output zeroFlag,
    output reg exe_regwrite,
    output reg exe_memtoreg,
    output reg exe_memwrite,
    output reg exe_memread,
    output reg [1:0]exe_RDsrc,
    output reg [31:0]exe_pctoreg,
    output reg [31:0]ALUout,
    output reg [31:0]csr_out,
    output reg [31:0]EX_forward_rs2_data,//ex rs2 data
    output reg [4:0]EX_rd_addr,
    output [31:0] pc_imm,
    output [31:0] pc_immrs,
    output reg [2:0]exe_func3
);
    logic [4:0]ALUCtrl;
    logic [31:0]in1;
    logic [31:0]in2;
    logic [31:0]rs2_data_wire;
    logic [31:0]ALUout_wire;
    logic [31:0]pctoreg_wire;
    logic [31:0]csr_wire;
    logic [63:0]cycle;
    logic [63:0]instr;

    assign pc_immrs = ALUout_wire;
    assign pc_imm = ID_PC + imm;

    ALU ALU(
        .ALUCtrl(ALUCtrl),
        .in1(in1),
        .in2(in2),
        .zeroFlag(zeroFlag),
        .ALUout(ALUout_wire)
    );
    ALUCtrl ALUCtrl1(
        .func7(func7),
        .func3(func3),
        .ALUOP(ALUOP),
        .ALUCtrl(ALUCtrl)
    );

    csr csr(
        /* .rden(rden),
        .csren(csren), */
        .imm(imm),
        .rs1_data(rs1_data),
        .func3(func3),
        .cycle(cycle),
        .instr(instr),
        .csr_out(csr_wire) 
    );

    always_comb begin 
        if(pctoreg) pctoreg_wire =ID_PC+imm;
        else pctoreg_wire =ID_PC+32'd4;
    end

    always_comb begin 
        if(Forward1==2'b10) in1 = rs1_data;
        else if(Forward1==2'b01) in1 = Forward_memrd_data;
        else in1 = Forward_wb_data;
    end

    always_comb begin 
        if(ALUsrc) begin
            if(Forward2==2'b10)begin
                in2 = rs2_data;
                rs2_data_wire = rs2_data;
            end 
            else if(Forward2==2'b01) begin 
                in2 = Forward_memrd_data;
                rs2_data_wire = Forward_memrd_data;
            end
            else begin
                in2 = Forward_wb_data;
                rs2_data_wire = Forward_wb_data;
            end 
        end
        else begin 
            in2 = imm; 
            if(Forward2==2'b10)
                rs2_data_wire = rs2_data; 
            else if(Forward2==2'b01)      
                rs2_data_wire = Forward_memrd_data;
            else    
                rs2_data_wire = Forward_wb_data;
                
        end
    end

    always @(posedge clk,posedge rst) begin
        if(rst) begin     
            exe_memtoreg <= 1'b0;
            exe_memwrite <= 1'b0;
            exe_memread <= 1'b0;
            exe_RDsrc <= 2'b00;
            exe_regwrite <= 1'b0;
            exe_pctoreg <= 32'b0;
            ALUout <= 32'b0;
            EX_forward_rs2_data <= 32'b0;
            EX_rd_addr <= 5'b0;
            exe_func3 <= 3'b0;
            csr_out <= 32'b0;
            cycle <= 64'b0;
            instr <= 64'b0;
        end
        else begin
            cycle <= cycle+1;
            if(csrminus==2'b00) instr <= instr +1;
            else if(csrminus==2'b10) instr <= instr-1;
            exe_memtoreg <= memtoreg;
            exe_memwrite <= memwrite;
            exe_memread <= memread;
            exe_RDsrc <= RDsrc;
            exe_regwrite <= regwrite;
            exe_pctoreg <= pctoreg_wire;
            ALUout <= ALUout_wire;
            EX_forward_rs2_data <= rs2_data_wire;
            EX_rd_addr <= rd_addr;
            csr_out <= csr_wire;
            exe_func3 <= func3;
        end

    end
    
endmodule









