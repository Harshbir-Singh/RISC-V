`timescale 1ns / 1ps
module Memory_cycle(clk, rst, RegWriteM, ResultSrcM, MemWriteM,ALUResultM,WriteDataM,PCPlus4M,RdM,ReadDataW,ALUResultW,PCPlus4W,RdW,RegWriteW,ResultSrcW,funct3M,ByteOffsetM,Upper_instM,Upper_instW);
  input clk, rst, RegWriteM, MemWriteM;
  input [31:0] ALUResultM,WriteDataM,PCPlus4M,Upper_instM;
  input [4:0] RdM;
  input [2:0] funct3M;
  input [1:0] ByteOffsetM,ResultSrcM;
  
  wire [31:0] RD;
  wire [31:0] loadRD;
  
  reg [31:0] RD_r, ALUResultM_r, PCPlus4M_r,Upper_instM_r;
  reg [4:0] RdM_r;
  reg RegWriteM_r;
  reg [1:0] ResultSrcM_r;
  reg  [3:0]  WBE;
  reg  [31:0] WD_aligned;
  
  output [31:0] ReadDataW, ALUResultW, PCPlus4W,Upper_instW;
  output [4:0] RdW  ;
  output RegWriteW;
  output [1:0] ResultSrcW;     

  always @(*) begin
    case(funct3M)
      3'b000: begin  // SB
        case(ByteOffsetM)
          2'b00: begin WBE = 4'b0001; WD_aligned = {24'b0, WriteDataM[7:0]};                    end
          2'b01: begin WBE = 4'b0010; WD_aligned = {16'b0, WriteDataM[7:0], 8'b0};              end
          2'b10: begin WBE = 4'b0100; WD_aligned = {8'b0,  WriteDataM[7:0], 16'b0};             end
          2'b11: begin WBE = 4'b1000; WD_aligned = {WriteDataM[7:0], 24'b0};                    end
          default: begin WBE = 4'b0000; WD_aligned = WriteDataM;                                end
        endcase
      end
      3'b001: begin  // SH
        if (ByteOffsetM[1] == 0) begin
          WBE = 4'b0011; WD_aligned = {16'b0, WriteDataM[15:0]};
        end else begin
          WBE = 4'b1100; WD_aligned = {WriteDataM[15:0], 16'b0};
        end
      end
      3'b010: begin  // SW
        WBE = 4'b1111; WD_aligned = WriteDataM;
      end
      default: begin
        WBE = 4'b0000; WD_aligned = WriteDataM;
      end
    endcase
  end
        
  Data_Memory DMEM(
    .clk(clk),
    .WE(MemWriteM),
    .WBE(WBE),
    .WD(WD_aligned),
    .A(ALUResultM),
    .RD(RD)
  );
  
  assign loadRD =  //LB
                  (funct3M == 3'b000) ?   
                  (ByteOffsetM == 2'b00) ? {{24{RD[7]}},  RD[7:0]}:
                  (ByteOffsetM == 2'b01) ? {{24{RD[15]}}, RD[15:8]}:
                  (ByteOffsetM == 2'b10) ? {{24{RD[23]}}, RD[23:16]}:
                                             {{24{RD[31]}}, RD[31:24]}:
                   // LH
                  (funct3M == 3'b001) ?   
                  (ByteOffsetM == 2'b00) ? {{16{RD[15]}}, RD[15:0]}:
                                             {{16{RD[31]}}, RD[31:16]}:
                   // LW
                  (funct3M == 3'b010) ? RD :
                  
                   // LBU
                  (funct3M == 3'b100) ?   
                  (ByteOffsetM == 2'b00) ? {24'b0, RD[7:0]}:
                  (ByteOffsetM == 2'b01) ? {24'b0, RD[15:8]}:
                  (ByteOffsetM == 2'b10) ? {24'b0, RD[23:16]}:
                                             {24'b0, RD[31:24]}:
                   // LHU
                  (funct3M == 3'b101) ?   
                  (ByteOffsetM == 2'b00) ? {16'b0, RD[15:0]}:
                                           {16'b0, RD[31:16]}:RD;
  
  always@(posedge clk or negedge rst)
    begin
      if(rst==1'b0)
        begin
          RD_r<=32'd0;
          ALUResultM_r<=32'd0;
          PCPlus4M_r<=32'd0;
          RdM_r<=5'b00000;
          RegWriteM_r <= 0;
          ResultSrcM_r<=0;
          Upper_instM_r<=32'd0;
        end
      else 
        begin
          RD_r <= loadRD;
          ALUResultM_r <= ALUResultM;
          PCPlus4M_r <= PCPlus4M;
          RdM_r <= RdM;
          RegWriteM_r <= RegWriteM;
          ResultSrcM_r<= ResultSrcM;
          Upper_instM_r<=Upper_instM;
        end
    end
    
   assign ReadDataW = RD_r;
   assign ALUResultW = ALUResultM_r;
   assign PCPlus4W = PCPlus4M_r;
   assign RdW = RdM_r;
   assign RegWriteW = RegWriteM_r;
   assign ResultSrcW = ResultSrcM_r;
   assign Upper_instW = Upper_instM_r;
   
endmodule
