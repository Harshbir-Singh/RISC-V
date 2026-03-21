`timescale 1ns / 1ps
module fetch_cycle(clk,rst,InstrD, PCD, PCPlus4D, PCSrcE, PCTargetE);
  input clk,rst,PCSrcE;
  input [31:0] PCTargetE;
  output [31:0] PCD,InstrD,PCPlus4D;
  
  wire [31:0] PC_F, PCF, PCPlus4F, InstrF;
  reg [31:0] InstrF_reg, PCF_reg, PCPlus4F_reg;
    
    
  Mux MUX(
  .a(PCPlus4F),
  .b(PCTargetE),
  .s(PCSrcE),
  .c(PC_F)
  );
  
  PC_Module Program_Counter(
    .clk(clk),
    .rst(rst),
    .PC(PCF),
    .PC_Next(PC_F)
  );
  
  PC_Adder Adder(
    .a(PCF),
    .b(32'd4),
    .c(PCPlus4F)
  );
  
  Instruction_Memory IMEM(
    .rst(rst),
    .A(PCF),
    .RD(InstrF)
  );
  
  always@(posedge clk or negedge rst)
    begin
      if(rst == 1'b0)
        begin
          InstrF_reg <= 32'h00000000;
          PCF_reg <= 32'h00000000;
          PCPlus4F_reg <= 32'h00000000;
        end
      else
        begin
          InstrF_reg <= InstrF;
          PCF_reg <= PCF;
          PCPlus4F_reg <= PCPlus4F;
        end
    end
  
  assign  InstrD = (rst == 1'b0) ? 32'h00000000 : InstrF_reg;
  assign  PCD = (rst == 1'b0) ? 32'h00000000 : PCF_reg;
  assign  PCPlus4D = (rst == 1'b0) ? 32'h00000000 : PCPlus4F_reg;
  
endmodule
