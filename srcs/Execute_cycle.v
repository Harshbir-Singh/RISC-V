`timescale 1ns / 1ps
module Execute_cycle(clk,rst,RD1E, RD2E, PCE, RdE, Imm_Ext_E, PCPlus4E, RegWriteE, ResultSrcE, MemWriteE, BranchE, ALUControlE, ALUSrcE, PCTargetE,JumpE, RegWriteM, ResultSrcM, MemWriteM,ALUResultM,WriteDataM, RdM, PCPlus4M, PCSrcE,ResultW,ForwardAE, ForwardBE,funct3E,funct3M,Jal_opE,Upper_instM);
  input clk,rst;
  input [1:0] ForwardAE, ForwardBE;
  input [31:0] RD1E, RD2E, PCE, Imm_Ext_E, PCPlus4E, ResultW;
  input [4:0] RdE;
  input [2:0] funct3E;
  input [6:0] Jal_opE;
  
  output RegWriteM, MemWriteM, PCSrcE;
  output [1:0] ResultSrcM;
  output [31:0] ALUResultM,WriteDataM,PCPlus4M;
  output [4:0] RdM;
  output [2:0] funct3M;

  wire [31:0] SrcBE, ALUResultE, SrcAE, WriteData_interim ;
  // BEQ, BNE
  wire ZeroE, BranchOut;
  //BLT, BGE, BLTU, BGEU
  wire SignE, OverflowE,CarryE;
  
  reg RegWriteE_r, MemWriteE_r;
  reg [1:0] ResultSrcE_r;
  reg [31:0] ALUResultE_r, WriteDataE_r, PCPlus4E_r,Upper_instE_r;
  reg [4:0] RdE_r ;
  reg [2:0] funct3E_r;
  
  wire [31:0] PCTargetE_JB,Upper_instE;
  
  input RegWriteE, MemWriteE, BranchE, ALUSrcE, JumpE;
  input [1:0] ResultSrcE;
  input [3:0] ALUControlE;
  output [31:0] PCTargetE, Upper_instM;
  

  PC_Adder Adder(
    .a(PCE),
    .b(Imm_Ext_E),
    .c(PCTargetE_JB)
  ); 
  
  assign PCTargetE = (Jal_opE == 7'b1100111)? {ALUResultE[31:1],1'b0}: // JALR
                                              PCTargetE_JB;  // JAL + Branch
                                              
  assign Upper_instE = (Jal_opE == 7'b0110111)? Imm_Ext_E: // LUI
                       (Jal_opE == 7'b0010111)? PCTargetE_JB: 32'h00000000; //AUIPC
  
  
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
    .OverFlow(OverflowE),
    .Carry(CarryE),
    .Zero(ZeroE),
    .Negative(SignE)
  );
  
  always@(posedge clk or negedge rst)
    begin
      if(rst == 1'b0) 
        begin
          RegWriteE_r <=0;
          ResultSrcE_r <=2'b00;
          MemWriteE_r <=0;
          ALUResultE_r <=32'd0;
          WriteDataE_r <=32'd0;
          PCPlus4E_r <=32'd0;
          RdE_r <=5'b00000;
          funct3E_r <= 3'b000;
          Upper_instE_r<=32'd0;
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
          funct3E_r<=funct3E;
          Upper_instE_r <= Upper_instE;
        end
    end
    
   
    assign BranchOut = (funct3E == 3'b000)? ZeroE & BranchE : //BEQ
                       (funct3E == 3'b001)? ~ZeroE & BranchE : //BNE
                       (funct3E == 3'b100)? (SignE ^ OverflowE) & BranchE : //BLT
                       (funct3E == 3'b101)? (~(SignE ^ OverflowE))& BranchE : //BGE
                       (funct3E == 3'b110)? ~CarryE & BranchE:  // BLTU
                       (funct3E == 3'b111)? CarryE & BranchE :1'b0; //BGEU
                                         
                       
    assign PCSrcE = BranchOut|JumpE; //Jal
    
    assign RegWriteM = RegWriteE_r;
    assign ResultSrcM = ResultSrcE_r;
    assign MemWriteM = MemWriteE_r;
    assign ALUResultM = ALUResultE_r;
    assign WriteDataM = WriteDataE_r;
    assign RdM = RdE_r;
    assign PCPlus4M = PCPlus4E_r;
    assign funct3M = funct3E_r;
    assign Upper_instM = Upper_instE_r;
    
    
endmodule
