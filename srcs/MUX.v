module Mux (
  input [31:0]a,
  input [31:0]b,
  input s,
  output [31:0]c
  );
  assign c = (~s) ? a : b ;
    
endmodule

module Mux_3x1(a,b,c,s,out);
  input [31:0] a,b,c;
  input [1:0] s;
  output [31:0] out;
  assign out = (s == 2'b00)?a:
               (s == 2'b01)?b:
               (s == 2'b10)?c:
               32'd0;
endmodule

module Mux_4x1(a,b,c,d,s,out);
  input [31:0] a,b,c,d;
  input [1:0] s;
  output [31:0] out;
  assign out = (s == 2'b00)?a:
               (s == 2'b01)?b:
               (s == 2'b10)?c:
               (s == 2'b11)?d:
               32'd0;
endmodule