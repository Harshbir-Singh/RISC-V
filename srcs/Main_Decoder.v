`timescale 1ns / 1ps

module Main_Decoder(Op, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp, Jump);
    input [6:0] Op;
    output reg RegWrite, ALUSrc, MemWrite, Branch, Jump;
    output reg [1:0] ResultSrc;
    output reg [2:0] ALUOp, ImmSrc;

    always @(*) begin
        case(Op)
            7'b0000011: begin  // Load
                RegWrite = 1'b1;  ImmSrc = 3'b000;  ALUSrc = 1'b1;
                MemWrite = 1'b0;  ResultSrc = 2'b01; Branch = 1'b0;
                ALUOp = 3'b011;   Jump = 1'b0;
            end
            7'b0110011: begin  // R-type
                RegWrite = 1'b1;  ImmSrc = 3'b000;  ALUSrc = 1'b0;
                MemWrite = 1'b0;  ResultSrc = 2'b00; Branch = 1'b0;
                ALUOp = 3'b010;   Jump = 1'b0;
            end
            7'b0010011: begin  // I-type 
                RegWrite = 1'b1;  ImmSrc = 3'b000;  ALUSrc = 1'b1;
                MemWrite = 1'b0;  ResultSrc = 2'b00; Branch = 1'b0;
                ALUOp = 3'b000;   Jump = 1'b0;
            end
            7'b1101111: begin  // JAL
                RegWrite = 1'b1;  ImmSrc = 3'b011;  ALUSrc = 1'b0;
                MemWrite = 1'b0;  ResultSrc = 2'b10; Branch = 1'b0;
                ALUOp = 3'b000;   Jump = 1'b1;       
            end
            7'b1100111: begin  // JALR
                RegWrite = 1'b1;  ImmSrc = 3'b000;  ALUSrc = 1'b1;  
                MemWrite = 1'b0;  ResultSrc = 2'b10; Branch = 1'b0;
                ALUOp = 3'b000;   Jump = 1'b1;
            end
            7'b0110111: begin  // LUI
                RegWrite = 1'b1;  ImmSrc = 3'b100;  ALUSrc = 1'b1;
                MemWrite = 1'b0;  ResultSrc = 2'b11; Branch = 1'b0;
                ALUOp = 3'b000;   Jump = 1'b0;       
            end
            7'b0010111: begin  // AUIPC
                RegWrite = 1'b1;  ImmSrc = 3'b100;  ALUSrc = 1'b1;
                MemWrite = 1'b0;  ResultSrc = 2'b11; Branch = 1'b0;
                ALUOp = 3'b000;   Jump = 1'b0;       
            end
            7'b0100011: begin  // Store
                RegWrite = 1'b0;  ImmSrc = 3'b001;  ALUSrc = 1'b1;
                MemWrite = 1'b1;  ResultSrc = 2'b00; Branch = 1'b0;
                ALUOp = 3'b011;   Jump = 1'b0;
            end
            7'b1100011: begin  // Branch
                RegWrite = 1'b0;  ImmSrc = 3'b010;  ALUSrc = 1'b0;
                MemWrite = 1'b0;  ResultSrc = 2'b00; Branch = 1'b1;  
                ALUOp = 3'b001;   Jump = 1'b0;
            end
            default: begin     
                RegWrite = 1'b0;  ImmSrc = 3'b000;  ALUSrc = 1'b0;
                MemWrite = 1'b0;  ResultSrc = 2'b00; Branch = 1'b0;
                ALUOp = 3'b000;   Jump = 1'b0;
            end
        endcase
    end

endmodule