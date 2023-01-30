module RegisterFile (
    input clk,
    input rst,
    input wb_regwrite,
    input [4:0]rs1_addr,
    input [4:0]rs2_addr,
    //input [4:0]csrrd_addr,
    input [4:0]rd_addr,
    input [31:0]rd_data,
    output [31:0]rs1_outdata,
    output [31:0]rs2_outdata
    //output [31:0]csrrd_data
);
    reg [31:0]register[0:31];
    integer i;
    assign rs1_outdata = register[rs1_addr];
    assign rs2_outdata = register[rs2_addr];
    //assign csrrd_data = register[csrrd_addr];
     
    always@(posedge clk,posedge rst)begin
        if(rst)begin
            for(i=0;i<32;i=i+1)begin
                register[i] <= 32'b0;
            end
        end
        else begin
            if(wb_regwrite && (rd_addr != 5'b0)) begin
                register[rd_addr] <= rd_data;
            end
        end
    end


endmodule









