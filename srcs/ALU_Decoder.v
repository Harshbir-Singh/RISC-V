`timescale 1ns / 1ps
module ALU_Decoder(ALUOp, funct3, funct7, op, ALUControl);
    input  [2:0] ALUOp;
    input  [2:0] funct3;
    input  [6:0] funct7, op;
    output reg [3:0] ALUControl;

    always @(*) begin
        case(ALUOp)

            3'b011: begin  
                case(funct3)
                    3'b000: ALUControl = 4'b0000; // LB, SB
                    3'b001: ALUControl = 4'b0000; // LH, SH
                    3'b010: ALUControl = 4'b0000; // LW, SW
                    3'b100: ALUControl = 4'b0000; // LBU
                    3'b101: ALUControl = 4'b0000; // LHU
                    default: ALUControl = 4'b0000;
                endcase
            end

            3'b001: begin  
                case(funct3)
                    3'b000: ALUControl = 4'b0001; // BEQ
                    3'b001: ALUControl = 4'b0001; // BNE
                    3'b100: ALUControl = 4'b0001; // BLT
                    3'b101: ALUControl = 4'b0001; // BGE
                    3'b110: ALUControl = 4'b0001; // BLTU
                    3'b111: ALUControl = 4'b0001; // BGEU
                    default: ALUControl = 4'b0000;
                endcase
            end

            3'b000: begin  
                case(funct3)
                    3'b000: ALUControl = 4'b0000; // ADDI, JALR
                    3'b001: ALUControl = 4'b0100; // SLLI
                    3'b010: ALUControl = 4'b0101; // SLTI
                    3'b011: ALUControl = 4'b0110; // SLTIU
                    3'b100: ALUControl = 4'b0111; // XORI
                    3'b101: ALUControl = (funct7[5]) ? 4'b1000 : 4'b1001; // SRAI : SRLI
                    3'b110: ALUControl = 4'b0011; // ORI
                    3'b111: ALUControl = 4'b0010; // ANDI
                    default: ALUControl = 4'b0000;
                endcase
            end

            3'b010: begin  
                case(funct3)
                    3'b000: ALUControl = ({op[5], funct7[5]} == 2'b11) ? 4'b0001 : 4'b0000; // SUB / ADD
                    3'b001: ALUControl = 4'b0100; // SLL
                    3'b010: ALUControl = 4'b0101; // SLT
                    3'b011: ALUControl = 4'b0110; // SLTU
                    3'b100: ALUControl = 4'b0111; // XOR
                    3'b101: ALUControl = ({op[5], funct7[5]} == 2'b11) ? 4'b1000 : 4'b1001; // SRA / SRL
                    3'b110: ALUControl = 4'b0011; // OR
                    3'b111: ALUControl = 4'b0010; // AND
                    default: ALUControl = 4'b0000;
                endcase
            end

            default: ALUControl = 4'b0000;

        endcase
    end

endmodule