//================================================
// Auther:      Tsai Zong-Hui (Claire)
// Filename:    regfile.sv
// Description: register file
// Version:     0.1
//================================================

`define REG_LENGTH 32
`define ADDR_BITS 5
`define REG_DEPTH 2 ** (`ADDR_BITS)

module regfile(
  input clk, 
  input rst,
  input wr_en,
  input [`ADDR_BITS-1:0] rd_addr,
  input [`ADDR_BITS-1:0] wr_addr,
  input [`REG_LENGTH-1:0] wr_data,  
  output [`REG_LENGTH-1:0] rd_data
);
  logic [`REG_LENGTH-1:0] mem [`REG_DEPTH-1:0]; 

  always_ff@(posedge clk or posedge rst) begin
    if(rst)
      for(int i=0; i<`REG_DEPTH; i++)         
        mem[i] <= `REG_LENGTH'b0;   
      else if(wr_en && (wr_addr != `ADDR_BITS'b0))
        mem[wr_addr] <= wr_data;
  end

  assign rd_data = mem[rd_addr];

endmodule
