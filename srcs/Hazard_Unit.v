`timescale 1ns / 1ps
module Hazard_Unit(RdM,RdW,RegWriteM,RegWriteW, ForwardAE, ForwardBE,RS1_E,RS2_E,ResultSrcE,RdE,RS1_D,RS2_D,FlushE,StallD,StallF,PCSrcE,FlushD);
  input [4:0] RdM, RdW, RS1_E, RS2_E,RdE, RS1_D, RS2_D;
  input [1:0] ResultSrcE;
  input RegWriteM, RegWriteW, PCSrcE;
  output [1:0] ForwardAE, ForwardBE;
  output FlushE,StallD,StallF,FlushD;
  
  wire lwstall;
  // Data Forwarding
  assign ForwardAE = ((RegWriteM==1'b1)&&(RdM!=5'b00000)&&(RdM == RS1_E))? 2'b10:
                     ((RegWriteW==1'b1)&&(RdW!=5'b00000)&&(RdW == RS1_E))? 2'b01:
                     2'b00;
  assign ForwardBE = ((RegWriteM==1'b1)&&(RdM!=0)&&(RdM == RS2_E))? 2'b10:
                     ((RegWriteW==1'b1)&&(RdW!=0)&&(RdW == RS2_E))? 2'b01:
                     2'b00;
                     
  //Stalling for LW:
  assign lwstall = ResultSrcE[0]&&((RS1_D == RdE) || (RS2_D == RdE));
  assign FlushE = lwstall | PCSrcE;
  assign StallD = lwstall;
  assign StallF = lwstall;
  
  //Handling Branch
  assign FlushD = PCSrcE;
endmodule
