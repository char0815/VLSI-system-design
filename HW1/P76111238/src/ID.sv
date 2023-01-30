`include "ControlUnit.sv"
`include "RegisterFile.sv"
`include "ImmediateGenerator.sv"

module ID (
    input clk,
    input rst,
    input [31:0]ifpc_out,
    input [31:0]ifins_out,
    input [31:0]wb_rd_data,
    input [4:0]wb_rd_addr,
    input ctrlflush,
    input wb_regwrite,
    output reg [2:0]ALUOP,
    output reg pctoreg,
    output reg ALUsrc,
    output reg [1:0]RDsrc,
    output reg memtoreg,
    output reg memwrite,
    output reg memread,
    output reg regwrite,
    output reg [1:0]branch,//branch&jump
    output reg [31:0]ID_PC,
    output reg [31:0]rs1_data,
    output reg [31:0]rs2_data,
    output reg [2:0]func3,
    output reg [6:0]func7,
    output reg [4:0]rs1_addr,
    output reg [4:0]rs2_addr,
    output reg [4:0]rd_addr,
    output reg [31:0]imm,
    output [4:0] forrs1_addr,
    output [4:0] forrs2_addr
    //output reg [31:0]csrrd_data
);
    logic [2:0]Immtype;
    logic [2:0]ALUop_wire;
    logic pctoreg_wire;
    logic ALUsrc_wire;
    logic [1:0]RDsrc_wire;
    logic memread_wire;
    logic memtoreg_wire;
    logic memwrite_wire;
    logic regwrite_wire;
    logic [1:0]branch_wire;
    logic [31:0]rs1_data_wire;
    logic [31:0]rs2_data_wire;
    logic [31:0]imm_wire;
    //logic [31:0]csrrd_data_wire;
    

    
    assign forrs1_addr = ifins_out[19:15];
    assign forrs2_addr = ifins_out[24:20];
    
    always_ff @(posedge clk or posedge rst) begin
        if(rst) begin
            ALUOP <= 3'b0;
            pctoreg <= 1'b0;
            ALUsrc <= 1'b0;
            RDsrc <= 2'b00;
            memtoreg <= 1'b0;
            memwrite <= 1'b0;
            memread <= 1'b0;
            regwrite <= 1'b0;
            branch <= 2'b0;
            ID_PC <= 32'b0;
            rs1_data <= 32'b0;
            rs2_data <= 32'b0;
            func3 <= 3'b0;
            func7 <= 7'b0;
            rs1_addr <= 5'b0;
            rs2_addr <= 5'b0;
            rd_addr <= 5'b0;
            imm <= 32'b0;
        end
        else begin
            //csrrd_data <= csrrd_data_wire;
            rs1_data <= rs1_data_wire;
            rs2_data <= rs2_data_wire;
            ID_PC <= ifpc_out;
            func3 <= ifins_out[14:12];
            func7 <= ifins_out[31:25];
            rs1_addr <= ifins_out[19:15];
            rs2_addr <= ifins_out[24:20];
            rd_addr <= ifins_out[11:7];
            imm <= imm_wire;
            if(ctrlflush) begin
                ALUOP <= ALUop_wire;
                pctoreg <= pctoreg_wire;
                ALUsrc <= ALUsrc_wire;
                RDsrc <= RDsrc_wire;
                memtoreg <= memtoreg_wire;
                memwrite <= 1'b0;
                memread <= 1'b0;
                regwrite <= 1'b0;
                branch <= 2'b0;
            end
            else begin
                ALUOP <= ALUop_wire;
                pctoreg <= pctoreg_wire;
                ALUsrc <= ALUsrc_wire;
                RDsrc <= RDsrc_wire;
                memtoreg <= memtoreg_wire;
                memwrite <= memwrite_wire;
                memread <= memread_wire;
                regwrite <= regwrite_wire;
                branch <= branch_wire;
            end
        end
    end
    
    ControlUnit ControlUnit(
        .opcode(ifins_out[6:0]),
        .func3(func3),
        .ALUop(ALUop_wire),
        .pctoreg(pctoreg_wire),
        .ALUsrc(ALUsrc_wire),
        .RDsrc(RDsrc_wire),
        .memtoreg(memtoreg_wire),
        .memwrite(memwrite_wire),
        .memread(memread_wire),
        .regwrite(regwrite_wire),
        .Immtype(Immtype),
        .branch(branch_wire)
    );

    RegisterFile RegisterFile(
        .clk(~clk),
        .rst(rst),
        .wb_regwrite(wb_regwrite),
        .rs1_addr(ifins_out[19:15]),
        .rs2_addr(ifins_out[24:20]),
        //.csrrd_addr(ifins_out[11:7]),
        .rd_addr(wb_rd_addr),
        .rd_data(wb_rd_data),
        .rs1_outdata(rs1_data_wire),
        .rs2_outdata(rs2_data_wire)
        //.csrrd_data(csrrd_data_wire)
    );
    
    ImmediateGenerator ImmediateGenerator(
        .Immtype(Immtype),
        .imm_in(ifins_out),
        .imm_out(imm_wire)
    );

endmodule









