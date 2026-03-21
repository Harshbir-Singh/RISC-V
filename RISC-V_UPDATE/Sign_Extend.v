`timescale 1ns / 1ps
module Sign_Extend (In,ImmSrc,Imm_Ext, funct3);
    input [31:0] In;
    input [1:0] ImmSrc;
    input [2:0] funct3;
    output [31:0] Imm_Ext;

    assign Imm_Ext =  (ImmSrc == 2'b00) ? {{20{In[31]}},In[31:20]} : //I types
                      (ImmSrc == 2'b01) ? {{20{In[31]}},In[31:25],In[11:7]} :
                      (ImmSrc == 2'b00) && (funct3 == 3'b001 || funct3 == 3'b101) ? {{27{1'b0}}, In[24:20]} :// slli,srli,srai
                      (ImmSrc == 2'b10) ? {{20{In[31]}}, In[31], In[7], In[30:25], In[11:8], 1'b0} :32'h00000000;  //B-Type

endmodule