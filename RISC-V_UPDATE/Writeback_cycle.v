`timescale 1ns / 1ps
module Writeback_cycle(ReadDataW, ALUResultW, PCPlus4W, ResultSrcW, ResultW);
  input [31:0] ReadDataW, ALUResultW, PCPlus4W;
  input ResultSrcW;
  
  output [31:0] ResultW; 
  
  Mux Mux_WriteBack(
    .a(ALUResultW),
    .b(ReadDataW),
    .s(ResultSrcW),
    .c(ResultW)
  );
       
endmodule
