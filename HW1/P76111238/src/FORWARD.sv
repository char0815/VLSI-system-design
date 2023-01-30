module FORWARD (
    input mem_regwrite,
    input exe_regwrite,
    input [4:0]rs1_addr,
    input [4:0]rs2_addr,
    input [4:0]EX_rd_addr,
    input [4:0]mem_rd_addr,
    output reg [1:0]Forward1,
    output reg [1:0]Forward2
    
);
    always_comb begin 
        if(exe_regwrite && (rs1_addr==EX_rd_addr)) Forward1 = 2'b01;
        else if(mem_regwrite && (rs1_addr==mem_rd_addr)) Forward1 = 2'b00;
        else Forward1 = 2'b10;
        
    end

    always_comb begin
        if(exe_regwrite && (rs2_addr==EX_rd_addr)) Forward2 = 2'b01;
        else if(mem_regwrite && (rs2_addr==mem_rd_addr)) Forward2 = 2'b00;
        else Forward2 = 2'b10;
    end
    
endmodule












