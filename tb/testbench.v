`timescale 1ns / 1ps
module RISC_V_tb();
  reg clk,rst;
  
  RISC_V dut(
    .clk(clk), 
    .rst(rst)
  );
    
  initial
    begin
      clk = 1;
      forever #50 clk = ~clk; 
    end
  initial 
    begin
      rst = 0;
      #400  
      rst = 1;
      #20000
      $finish();
    end
endmodule
