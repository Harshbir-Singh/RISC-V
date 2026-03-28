`timescale 1ns / 1ps
module Writeback_cycle(ReadDataW, ALUResultW, PCPlus4W, ResultSrcW, ResultW,Upper_instW);
  input [31:0] ReadDataW, ALUResultW, PCPlus4W,Upper_instW;
  input [1:0] ResultSrcW;
  
  output [31:0] ResultW; 
  
  Mux_4x1 Mux_WriteBack(
      .a(ALUResultW),
      .b(ReadDataW),
      .c(PCPlus4W),
      .d(Upper_instW),
      .s(ResultSrcW),
      .out(ResultW)
  );
       
endmodule
