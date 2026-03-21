`timescale 1ns / 1ps
module Hazard_Unit(rst,RdM,RdW,RegWriteM,RegWriteW, ForwardAE, ForwardBE,RS1_E,RS2_E);
  input [4:0] RdM, RdW, RS1_E, RS2_E;
  input rst, RegWriteM, RegWriteW;
  output [1:0] ForwardAE, ForwardBE;
  assign ForwardAE = (rst==1'b0) ? 2'b00:
                     ((RegWriteM==1'b1)&&(RdM!=5'b00000)&&(RdM == RS1_E))? 2'b10:
                     ((RegWriteW==1'b1)&&(RdW!=5'b00000)&&(RdW == RS1_E))? 2'b01:
                     2'b00;
  assign ForwardBE = (rst==1'b0) ? 2'b00:
                     ((RegWriteM==1'b1)&&(RdM!=0)&&(RdM == RS2_E))? 2'b10:
                     ((RegWriteW==1'b1)&&(RdW!=0)&&(RdW == RS2_E))? 2'b01:
                     2'b00;
endmodule
