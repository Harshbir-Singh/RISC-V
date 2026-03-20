`timescale 1ns / 1ps
module RISC_V(clk, rst);
  input clk, rst;
  
  wire [31:0] InstrD,PCD, PCPlus4D, PCTargetE, ResultW, RD1_E, RD2_E,PCE,PCPlus4E,WriteDataM,ALUResultM,PCPlus4M,ReadDataW,ALUResultW,PCPlus4W,Imm_Ext_E;
  wire [4:0] RdW,RD_E, RdM, RS1_E,RS2_E;
  wire PCSrcE, RegWriteW,ResultSrcW, RegWriteE, ALUSrcE,MemWriteE,ResultSrcE,BranchE,RegWriteM,ResultSrcM,MemWriteM;
  wire [2:0] ALUControlE;
  wire [1:0] ForwardAE, ForwardBE;
  
  fetch_cycle Fetch(
    .clk(clk),
    .rst(rst),
    .InstrD(InstrD), 
    .PCD(PCD), 
    .PCPlus4D(PCPlus4D), 
    .PCSrcE(PCSrcE), 
    .PCTargetE(PCTargetE)
  );
  
  Decode_Cycle Decode(
    .clk(clk), 
    .rst(rst), 
    .InstrD(InstrD), 
    .RegWriteW(RegWriteW), 
    .PCD(PCD), 
    .PCPlus4D(PCPlus4D), 
    .ResultW(ResultW), 
    .RdW(RdW), 
    .RegWriteE(RegWriteE), 
    .ALUSrcE(ALUSrcE), 
    .MemWriteE(MemWriteE), 
    .ResultSrcE(ResultSrcE),
    .BranchE(BranchE),  
    .ALUControlE(ALUControlE), 
    .RD1_E(RD1_E), 
    .RD2_E(RD2_E), 
    .Imm_Ext_E(Imm_Ext_E), 
    .RD_E(RD_E), 
    .PCE(PCE), 
    .PCPlus4E(PCPlus4E), 
    .RS1_E(RS1_E), 
    .RS2_E(RS2_E)
  );
  
  Execute_cycle Execute(
    .clk(clk),
    .rst(rst),
    .RD1E(RD1_E), 
    .RD2E(RD2_E), 
    .PCE(PCE), 
    .RdE(RD_E), 
    .Imm_Ext_E(Imm_Ext_E), 
    .PCPlus4E(PCPlus4E), 
    .RegWriteE(RegWriteE), 
    .ResultSrcE(ResultSrcE), 
    .MemWriteE(MemWriteE), 
    .BranchE(BranchE), 
    .ALUControlE(ALUControlE), 
    .ALUSrcE(ALUSrcE), 
    .PCTargetE(PCTargetE),
    .RegWriteM(RegWriteM), 
    .ResultSrcM(ResultSrcM), 
    .MemWriteM(MemWriteM),
    .ALUResultM(ALUResultM),
    .WriteDataM(WriteDataM), 
    .RdM(RdM), 
    .PCPlus4M(PCPlus4M), 
    .PCSrcE(PCSrcE),
    .ResultW(ResultW),
    .ForwardAE(ForwardAE), 
    .ForwardBE(ForwardBE)
  );
  
  Memory_cycle Memory(
    .clk(clk), 
    .rst(rst), 
    .RegWriteM(RegWriteM), 
    .ResultSrcM(ResultSrcM), 
    .MemWriteM(MemWriteM),
    .ALUResultM(ALUResultM),
    .WriteDataM(WriteDataM),
    .PCPlus4M(PCPlus4M),
    .RdM(RdM),
    .ReadDataW(ReadDataW),
    .ALUResultW(ALUResultW),
    .PCPlus4W(PCPlus4W),
    .RdW(RdW),
    .RegWriteW(RegWriteW),
    .ResultSrcW(ResultSrcW)
  );
  
  Writeback_cycle Writeback(
    .ReadDataW(ReadDataW), 
    .ALUResultW(ALUResultW),
    .PCPlus4W(PCPlus4W), 
    .ResultSrcW(ResultSrcW), 
    .ResultW(ResultW)
  );
  Hazard_Unit Forwarding(
    .rst(rst),
    .RdM(RdM),
    .RdW(RdW),
    .RegWriteM(RegWriteM),
    .RegWriteW(RegWriteW), 
    .ForwardAE(ForwardAE), 
    .ForwardBE(ForwardBE),
    .RS1_E(RS1_E),
    .RS2_E(RS2_E)
  );
endmodule
