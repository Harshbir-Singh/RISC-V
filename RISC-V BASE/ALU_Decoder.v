`timescale 1ns / 1ps

module ALU_Decoder(ALUOp,funct3,funct7,op,ALUControl);

    input [1:0]ALUOp;
    input [2:0]funct3;
    input [6:0]funct7,op;
    output [2:0]ALUControl;

    assign ALUControl = (ALUOp == 2'b00) ? 3'b000 : //lw,sw
                        (ALUOp == 2'b01) ? 3'b001 : //beq
                        ((ALUOp == 2'b10) & (funct3 == 3'b000) & ({op[5],funct7[5]} == 2'b11)) ? 3'b001 :  //Sub
                        ((ALUOp == 2'b10) & (funct3 == 3'b000) & ({op[5],funct7[5]} != 2'b11)) ? 3'b000 : //Add
                        ((ALUOp == 2'b10) & (funct3 == 3'b010)) ? 3'b101 : //Slt
                        ((ALUOp == 2'b10) & (funct3 == 3'b110)) ? 3'b011 : //Or
                        ((ALUOp == 2'b10) & (funct3 == 3'b111)) ? 3'b010 : //and
                                                                  3'b000 ;
endmodule