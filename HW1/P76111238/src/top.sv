`include "SRAM_wrapper.sv"
`include "IF.sv"
`include "ID.sv"
`include "EXE.sv"
`include "MEM.sv"
`include "WB.sv"
`include "Branch.sv"
`include "FORWARD.sv"
`include "Hazard.sv"

module top (
    input clk,
    input rst
);

   logic [1:0]branchctrl;
   logic [31:0]pc_immrs1;
   logic [31:0]pc_imm;
   logic insflush;
   logic ifid_regwrite;
   logic PCWrite;
   logic [31:0]instr_out;
   logic [31:0]ifpc_out;
   logic [31:0]ifins_out;
   logic [31:0]pc_out;
   
SRAM_wrapper IM1(
   .CK(~clk),
   .CS(1'b1),
   .OE(1'b1),
   .WEB(4'b1111), // low active
   .A(pc_out[15:2]),
   .DI(32'b0),
   .DO(instr_out)
);

IF IF(
   .clk(clk),
   .rst(rst),
   .branchctrl(branchctrl),
   .pc_immrs1(pc_immrs1),
   .pc_imm(pc_imm),

   .insflush(insflush),
   .ifid_regwrite(ifid_regwrite),
   .PCWrite(PCWrite),
   .instr_out(instr_out),

   .ifpc_out(ifpc_out),
   .ifins_out(ifins_out),
   .pc_out(pc_out)
);



   logic [31:0]wb_rd_data;
   logic [4:0]wb_rd_addr;
   logic ctrlflush;
   logic wb_regwrite;
   logic [2:0]ALUOP;
   logic pctoreg;
   logic ALUsrc;
   logic [1:0]RDsrc;
   logic memtoreg;
   logic memwrite;
   logic memread;
   logic regwrite;
   logic [1:0]branch;
   logic [31:0]ID_PC;
   logic [31:0]rs1_data;
   logic [31:0]rs2_data;
   logic [2:0]func3;
   logic [6:0]func7;
   logic [4:0]rs1_addr;
   logic [4:0]rs2_addr;
   logic [4:0]rd_addr;
   logic [31:0]imm;
   logic [4:0]forrs1_addr;
   logic [4:0]forrs2_addr;
   //logic [31:0]csrrd_data;

ID ID(
   .clk(clk),
   .rst(rst),
   .ifpc_out(ifpc_out),
   .ifins_out(ifins_out),
   .wb_rd_data(wb_rd_data),
   .wb_rd_addr(wb_rd_addr),
   .ctrlflush(ctrlflush),
   .wb_regwrite(wb_regwrite),
   .ALUOP(ALUOP),
   .pctoreg(pctoreg),
   .ALUsrc(ALUsrc),
   .RDsrc(RDsrc),
   .memtoreg(memtoreg),
   .memwrite(memwrite),
   .memread(memread),
   .regwrite(regwrite),
   .branch(branch),//branch&jump
   .ID_PC(ID_PC),
   .rs1_data(rs1_data),
   .rs2_data(rs2_data),
   .func3(func3),
   .func7(func7),
   .rs1_addr(rs1_addr),
   .rs2_addr(rs2_addr),
   .rd_addr(rd_addr),
   .imm(imm),
   .forrs1_addr(forrs1_addr),
   .forrs2_addr(forrs2_addr)
   //.csrrd_data(csrrd_data)
);

   logic [1:0]Forward1;
   logic [1:0]Forward2;
   logic [31:0]Forward_memrd_data;
   logic [31:0]Forward_wb_data;
   logic zeroFlag;
   logic exe_regwrite;
   logic exe_memtoreg;
   logic exe_memwrite;
   logic exe_memread;
   logic [1:0]exe_RDsrc;
   logic [31:0]exe_pctoreg;
   
   logic [31:0]csr_out;
   logic [31:0]ALUout;
   logic [31:0]EX_forward_rs2_data;
   logic [4:0]EX_rd_addr;
   logic [2:0]exe_func3;
   logic [1:0]csrminus;

EXE EXE(
   .rst(rst),
   .clk(clk),
   .csrminus(csrminus),
   .ID_PC(ID_PC),
   .rs1_data(rs1_data),
   .rs2_data(rs2_data),
   .func3(func3),
   .func7(func7),
   .imm(imm),
   .ALUOP(ALUOP),
   .rd_addr(rd_addr),
   .pctoreg(pctoreg),
   .ALUsrc(ALUsrc),
   .RDsrc(RDsrc),
   .memtoreg(memtoreg),
   .memwrite(memwrite),
   .memread(memread),
   .regwrite(regwrite),
   .Forward1(Forward1),
   .Forward2(Forward2),
   .Forward_memrd_data(Forward_memrd_data),
   .Forward_wb_data(Forward_wb_data),
   //.csrrd_data(csrrd_data),
   .zeroFlag(zeroFlag),
   .exe_regwrite(exe_regwrite),
   .exe_memtoreg(exe_memtoreg),
   .exe_memwrite(exe_memwrite),
   .exe_memread(exe_memread),
   .exe_RDsrc(exe_RDsrc),
   .exe_pctoreg(exe_pctoreg),
   .ALUout(ALUout),
   .csr_out(csr_out),
   .EX_forward_rs2_data(EX_forward_rs2_data),
   .EX_rd_addr(EX_rd_addr),
   .pc_imm(pc_imm),
   .pc_immrs(pc_immrs1),
   .exe_func3(exe_func3)
);

logic mem_memwrite;
logic [31:0]mem_datain;
logic [31:0]mem_dataout_wire;
logic fdmem_regwrite;
logic mem_regwrite;
logic mem_memtoreg;
logic [4:0]mem_rd_addr;
logic [31:0]mem_rd_data;
logic [31:0]mem_dataout;
logic [31:0]mem_addr;
logic CS;
logic [3:0]WEB;

MEM MEM(
   .rst(rst),
   .clk(clk),
   .exe_memwrite(exe_memwrite),
   .exe_regwrite(exe_regwrite),
   .exe_memread(exe_memread),
   .exe_memtoreg(exe_memtoreg),
   .exe_RDsrc(exe_RDsrc),
   .mem_dataout_wire(mem_dataout_wire),
   .ALUout(ALUout),
   .csr_out(csr_out),
   .EX_forward_rs2_data(EX_forward_rs2_data),
   .EX_rd_addr(EX_rd_addr),
   .exe_pctoreg(exe_pctoreg),
   .exe_func3(exe_func3),
   .fdmem_regwrite(fdmem_regwrite),
   .mem_regwrite(mem_regwrite),
   .mem_memtoreg(mem_memtoreg),
   .mem_rd_data(mem_rd_data), 
   .mem_rd_addr(mem_rd_addr),
   .mem_dataout(mem_dataout),
   .mem_datain(mem_datain),
   .Forward_memrd_data(Forward_memrd_data),
   .CS(CS),
   .WEB (WEB)
);

SRAM_wrapper DM1(
   .CK  (~clk),
   .CS  (CS),
   .OE  (exe_memread),
   .WEB (WEB),
   .A   (ALUout[15:2]),
   .DI  (mem_datain),
   .DO  (mem_dataout_wire)
);

WB WB(
   .mem_memtoreg(mem_memtoreg),
   .mem_regwrite(mem_regwrite),
   .mem_rd_data(mem_rd_data), 
   .mem_rd_addr(mem_rd_addr),
   .mem_dataout(mem_dataout),
   .wb_regwrite(wb_regwrite),
   .wb_rd_data(wb_rd_data),
   .Forward_wb_data(Forward_wb_data),
   .wb_rd_addr(wb_rd_addr)
);

FORWARD FORWARD(
   .mem_regwrite(mem_regwrite),
   .exe_regwrite(exe_regwrite),
   .rs1_addr(rs1_addr),
   .rs2_addr(rs2_addr),
   .EX_rd_addr(EX_rd_addr),
   .mem_rd_addr(mem_rd_addr),
   .Forward1(Forward1),
   .Forward2(Forward2)
);

Branch BRANCH(
   .zeroFlag(zeroFlag),
   .branch(branch),
   .branchctrl(branchctrl)
);

Hazard HAZARD(
   .branchctrl(branchctrl),
   .rd_addr(rd_addr),
   .memread(memread),
   .rs1_addr(forrs1_addr),
   .rs2_addr(forrs2_addr),
   .ctrlflush(ctrlflush),
   .ifid_regwrite(ifid_regwrite),
   .insflush(insflush),
   .PCWrite(PCWrite),
   .csrminus(csrminus)
);


endmodule










