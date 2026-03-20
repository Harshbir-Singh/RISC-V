`timescale 1ns / 1ps
module Memory_cycle(clk, rst, RegWriteM, ResultSrcM, MemWriteM,ALUResultM,WriteDataM,PCPlus4M,RdM,ReadDataW,ALUResultW,PCPlus4W,RdW,RegWriteW,ResultSrcW);
  input clk, rst, RegWriteM, ResultSrcM, MemWriteM;
  input [31:0] ALUResultM,WriteDataM,PCPlus4M;
  input [4:0] RdM;
  
  wire [31:0] RD;
  
  reg [31:0] RD_r, ALUResultM_r, PCPlus4M_r;
  reg [4:0] RdM_r;
  reg RegWriteM_r,ResultSrcM_r;
  
  output [31:0] ReadDataW, ALUResultW, PCPlus4W;
  output [4:0] RdW  ;
  output RegWriteW, ResultSrcW;      
          
  Data_Memory DMEM(
    .clk(clk),
    .rst(rst),
    .WE(MemWriteM),
    .WD(WriteDataM),
    .A(ALUResultM),
    .RD(RD)
  );
  
  always@(posedge clk or negedge rst)
    begin
      if(rst==1'b0)
        begin
          RD_r<=32'd0;
          ALUResultM_r<=32'd0;
          PCPlus4M_r<=32'd0;
          RdM_r<=5'b00000;
          RegWriteM_r <= 0;
          ResultSrcM_r<=0;
        end
      else 
        begin
          RD_r <= RD;
          ALUResultM_r <= ALUResultM;
          PCPlus4M_r <= PCPlus4M;
          RdM_r <= RdM;
          RegWriteM_r <= RegWriteM;
          ResultSrcM_r<= ResultSrcM;
        end
    end
    
   assign ReadDataW = RD_r;
   assign ALUResultW = ALUResultM_r;
   assign PCPlus4W = PCPlus4M_r;
   assign RdW = RdM_r;
   assign RegWriteW = RegWriteM_r;
   assign ResultSrcW = ResultSrcM_r;
   
endmodule
