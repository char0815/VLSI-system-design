module WB (
    input mem_memtoreg,
    input mem_regwrite,
    input [31:0]mem_rd_data, 
    input [4:0]mem_rd_addr,
    input [31:0]mem_dataout,
    
    output reg wb_regwrite,
    output reg [31:0]wb_rd_data,
    output reg [31:0]Forward_wb_data,
    output reg [4:0]wb_rd_addr
);
    always_comb begin 
        if(mem_memtoreg) begin 
            wb_rd_data = mem_rd_data;
            Forward_wb_data = mem_rd_data;
        end
        else begin
            wb_rd_data = mem_dataout;
            Forward_wb_data = mem_dataout;
        end
        
        wb_rd_addr = mem_rd_addr;
        wb_regwrite = mem_regwrite;
    end
endmodule









