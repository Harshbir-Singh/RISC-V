`timescale 1ns / 1ps

module ALU_Decoder(ALUOp,funct3,funct7,op,ALUControl);

    input [1:0]ALUOp;
    input [2:0]funct3;
    input [6:0]funct7,op;
    output [3:0]ALUControl;

    assign ALUControl = //Immediate - TYPE
                        ((ALUOp == 2'b00) & (funct3 == 3'b000)) ? 4'b0000 : //AddI
                        ((ALUOp == 2'b00) & (funct3 == 3'b010)) ? 4'b0101 : //Slti
                        ((ALUOp == 2'b00) & (funct3 == 3'b011)) ? 4'b0110 : //Sltu
                        ((ALUOp == 2'b00) & (funct3 == 3'b100)) ? 4'b0111 : //XorI
                        ((ALUOp == 2'b00) & (funct3 == 3'b110)) ? 4'b0011 : //OrI
                        ((ALUOp == 2'b00) & (funct3 == 3'b111)) ? 4'b0010 : //AndI
                        ((ALUOp == 2'b00) & (funct3 == 3'b001)) ? 4'b0100 : //SllI
                        ((ALUOp == 2'b00) & (funct3 == 3'b101) & ({op[5],funct7[5]} == 2'b11)) ? 4'b1000 : //SRAI
                        ((ALUOp == 2'b00) & (funct3 == 3'b101) & ({op[5],funct7[5]} != 2'b11)) ? 4'b1001 : //SRLI

                        (ALUOp == 2'b01) ? 4'b0001 : //beq
                        // R - TYPE
                        ((ALUOp == 2'b10) & (funct3 == 3'b000) & ({op[5],funct7[5]} == 2'b11)) ? 4'b0001 :  //Sub
                        ((ALUOp == 2'b10) & (funct3 == 3'b000) & ({op[5],funct7[5]} != 2'b11)) ? 4'b0000 : //Add
                        ((ALUOp == 2'b10) & (funct3 == 3'b010)) ? 4'b0101 : //Slt
                        ((ALUOp == 2'b10) & (funct3 == 3'b110)) ? 4'b0011 : //Or
                        ((ALUOp == 2'b10) & (funct3 == 3'b111)) ? 4'b0010 : //and
                        ((ALUOp == 2'b10) & (funct3 == 3'b001)) ? 4'b0100 : //Sll
                        ((ALUOp == 2'b10) & (funct3 == 3'b011)) ? 4'b0110 : //Sltu
                        ((ALUOp == 2'b10) & (funct3 == 3'b100)) ? 4'b0111 : //XOR
                        ((ALUOp == 2'b10) & (funct3 == 3'b101) & ({op[5],funct7[5]} == 2'b11)) ? 4'b1000 :  //SRA
                        ((ALUOp == 2'b10) & (funct3 == 3'b101) & ({op[5],funct7[5]} != 2'b11)) ? 4'b1001 : //SRL
                                                                  4'b0000 ;
endmodule