`timescale 1ns / 1ps
module Sign_Extend (In, ImmSrc, Imm_Ext, funct3);
    input  [31:0] In;
    input  [2:0]  ImmSrc;
    input  [2:0]  funct3;
    output reg [31:0] Imm_Ext;

    always @(*) begin
        case(ImmSrc)
            3'b000: begin  // I-type, Load, JALR
                if (funct3 == 3'b001 || funct3 == 3'b101)
                    Imm_Ext = {{27{1'b0}}, In[24:20]};       // SLLI, SRLI, SRAI
                else
                    Imm_Ext = {{20{In[31]}}, In[31:20]};     // ADDI, SLTI....
            end
            3'b001: Imm_Ext = {{20{In[31]}}, In[31:25], In[11:7]};                    // S-type 
            3'b010: Imm_Ext = {{20{In[31]}}, In[31], In[7], In[30:25], In[11:8], 1'b0}; // B-type 
            3'b011: Imm_Ext = {{12{In[31]}}, In[19:12], In[20], In[30:21], 1'b0};    // JAL
            3'b100: Imm_Ext = {In[31:12], 12'h000};                                   // U-type LUI/AUIPC
            default: Imm_Ext = 32'h00000000;
        endcase
    end

endmodule