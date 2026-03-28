`timescale 1ns / 1ps
module ALU(A,B,Result,ALUControl,OverFlow,Carry,Zero,Negative);

    input [31:0]A,B;
    input [3:0]ALUControl;
    output Carry,OverFlow,Zero,Negative;
    output [31:0]Result;

    wire Cout;
    wire [32:0]Sum;
    wire [31:0] sra_result;
    assign sra_result = $signed(A) >>> B[4:0];

    assign Sum = (ALUControl[0] == 1'b0) ?({1'b0,A} + {1'b0,B}) : ({1'b0,A} + ({1'b0,(~B)}+1)) ;
    assign {Cout,Result} = (ALUControl == 4'b0000) ? Sum : //Add, JALR
                           (ALUControl == 4'b0001) ? Sum : //Sub
                           (ALUControl == 4'b0010) ? A & B : //And
                           (ALUControl == 4'b0011) ? A | B : //Or
                           (ALUControl == 4'b0101) ? {31'b0, (Sum[31] ^ ((Sum[31]^A[31])&(A[31]^B[31])))}: //SLT
                           (ALUControl == 4'b0100) ? {1'b0, A << B[4:0]} : //sll
                           (ALUControl == 4'b0110) ? {1'b0, 31'b0, ($unsigned(A) < $unsigned(B))} : //sltu
                           (ALUControl == 4'b0111) ? A^B : //Xor
                           (ALUControl == 4'b1000) ? {A[31], sra_result} : //SRA
                           (ALUControl == 4'b1001) ? {1'b0, A >> B[4:0]} : //SRL
                           {33{1'b0}};
                           
    assign OverFlow = ((Sum[31] ^ A[31]) & 
                      (~(ALUControl[0] ^ B[31] ^ A[31])) &
                      (~ALUControl[1]));
    assign Carry = ((~ALUControl[1]) & Cout);
    assign Zero = &(~Result);
    assign Negative = Result[31];

endmodule