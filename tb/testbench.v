`timescale 1ns / 1ps
module RISC_V_tb();

  reg clk, rst;
  integer cycle_count;

  RISC_V dut(.clk(clk), .rst(rst));

  initial clk = 1;
  always #50 clk = ~clk;

  initial cycle_count = 0;
  always @(posedge clk)
    if (rst) cycle_count = cycle_count + 1;

  initial begin
    rst = 0;
    #400
    rst = 1;
    #20000

    $display("=== FINAL REGISTER VALUES ===");
    $display("x0  = %0h", dut.Decode.RF.Register[0]);
    $display("x1  = %0h", dut.Decode.RF.Register[1]);
    $display("x2  = %0h", dut.Decode.RF.Register[2]);
    $display("x3  = %0h", dut.Decode.RF.Register[3]);
    $display("x4  = %0h", dut.Decode.RF.Register[4]);
    $display("x5  = %0h", dut.Decode.RF.Register[5]);
    $display("x6  = %0h", dut.Decode.RF.Register[6]);
    $display("x7  = %0h", dut.Decode.RF.Register[7]);
    $display("x8  = %0h", dut.Decode.RF.Register[8]);
    $display("x9  = %0h", dut.Decode.RF.Register[9]);
    $display("x10 = %0h", dut.Decode.RF.Register[10]);
    $display("x11 = %0h", dut.Decode.RF.Register[11]);
    $display("x12 = %0h", dut.Decode.RF.Register[12]);
    $display("x13 = %0h", dut.Decode.RF.Register[13]);
    $display("x14 = %0h", dut.Decode.RF.Register[14]);
    $display("x15 = %0h", dut.Decode.RF.Register[15]);
    $display("x16 = %0h", dut.Decode.RF.Register[16]);
    $display("x17 = %0h", dut.Decode.RF.Register[17]);
    $display("x18 = %0h", dut.Decode.RF.Register[18]);
    $display("x19 = %0h", dut.Decode.RF.Register[19]);
    $display("x20 = %0h", dut.Decode.RF.Register[20]);
    $display("x21 = %0h", dut.Decode.RF.Register[21]);
    $display("x22 = %0h", dut.Decode.RF.Register[22]);
    $display("x23 = %0h", dut.Decode.RF.Register[23]);
    $display("x24 = %0h", dut.Decode.RF.Register[24]);
    $display("x25 = %0h", dut.Decode.RF.Register[25]);
    $display("x26 = %0h", dut.Decode.RF.Register[26]);
    $display("x27 = %0h", dut.Decode.RF.Register[27]);
    $display("x28 = %0h", dut.Decode.RF.Register[28]);
    $display("x29 = %0h", dut.Decode.RF.Register[29]);
    $display("x30 = %0h", dut.Decode.RF.Register[30]);
    $display("x31 = %0h", dut.Decode.RF.Register[31]);
    

    $finish();
  end

endmodule
