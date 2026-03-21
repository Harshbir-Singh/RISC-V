`timescale 1ns / 1ps
module Execute_cycle(clk,rst,RD1E, RD2E, PCE, RdE, Imm_Ext_E, PCPlus4E, RegWriteE, ResultSrcE, MemWriteE, BranchE, ALUControlE, ALUSrcE, PCTargetE, RegWriteM, ResultSrcM, MemWriteM,ALUResultM,WriteDataM, RdM, PCPlus4M, PCSrcE,ResultW,ForwardAE, ForwardBE);
  input clk,rst;
  input [1:0] ForwardAE, ForwardBE;
  input [31:0] RD1E, RD2E, PCE, Imm_Ext_E, PCPlus4E, ResultW;
  input [4:0] RdE;
  
  output RegWriteM, ResultSrcM, MemWriteM, PCSrcE;
  output [31:0] ALUResultM,WriteDataM,PCPlus4M;
  output [4:0] RdM;

  wire [31:0] SrcBE, ALUResultE, SrcAE, WriteData_interim ;
  
  
  reg RegWriteE_r, ResultSrcE_r, MemWriteE_r;
  reg [31:0] ALUResultE_r, WriteDataE_r, PCPlus4E_r;
  reg [4:0] RdE_r ;
  wire ZeroE;
  
  input RegWriteE, ResultSrcE, MemWriteE, BranchE, ALUSrcE;
  input [3:0] ALUControlE;
  output [31:0] PCTargetE;
  

  PC_Adder Adder(
    .a(PCE),
    .b(Imm_Ext_E),
    .c(PCTargetE)
  ); 
  
  Mux MUX_E (
    .a(WriteData_interim),
    .b(Imm_Ext_E),
    .s(ALUSrcE),
    .c(SrcBE)
  );
  Mux_3x1 A_operand(
    .a(RD1E),
    .b(ResultW),
    .c(ALUResultM),
    .s(ForwardAE),
    .out(SrcAE)
  );
  
  Mux_3x1 B_operand(
    .a(RD2E),
    .b(ResultW),
    .c(ALUResultM),
    .s(ForwardBE),
    .out(WriteData_interim)
  );
  
  ALU alu(
    .A(SrcAE),
    .B(SrcBE),
    .Result(ALUResultE),
    .ALUControl(ALUControlE),
    .OverFlow(),
    .Carry(),
    .Zero(ZeroE),
    .Negative()
  );
  
  always@(posedge clk or negedge rst)
    begin
      if(rst == 1'b0) 
        begin
          RegWriteE_r <=0;
          ResultSrcE_r <=0;
          MemWriteE_r <=0;
          ALUResultE_r <=32'd0;
          WriteDataE_r <=32'd0;
          PCPlus4E_r <=32'd0;
          RdE_r <=5'b00000;
        end
      else 
        begin
          RegWriteE_r <= RegWriteE;
          ResultSrcE_r <= ResultSrcE;
          MemWriteE_r <= MemWriteE;
          ALUResultE_r <= ALUResultE;
          WriteDataE_r <= WriteData_interim;
          PCPlus4E_r <= PCPlus4E;
          RdE_r <= RdE;
        end
    end
    
    assign PCSrcE = ZeroE & BranchE;
    
    assign RegWriteM = RegWriteE_r;
    assign ResultSrcM = ResultSrcE_r;
    assign MemWriteM = MemWriteE_r;
    assign ALUResultM = ALUResultE_r;
    assign WriteDataM = WriteDataE_r;
    assign RdM = RdE_r;
    assign PCPlus4M = PCPlus4E_r;
    
    
endmodule
