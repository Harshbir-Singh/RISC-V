`timescale 1ns / 1ps
module Register_File(clk,rst,WE3,WD3,A1,A2,A3,RD1,RD2);

    input clk,rst,WE3;
    input [4:0]A1,A2,A3;
    input [31:0]WD3;
    output [31:0]RD1,RD2;

    reg [31:0] Register [31:0];
    integer i;
    always @(posedge clk or negedge rst) begin
        if (rst == 1'b0) begin
            for (i = 0; i < 32; i = i + 1) begin
                Register[i] <= 32'h00000000;
            end
        end
        else if (WE3 && (A3 != 5'h00)) begin
            Register[A3] <= WD3;
        end
    end

    assign RD1 = (WE3 && A3==A1 && A3!=0) ? WD3:
                  Register[A1];

    assign RD2 = (WE3 && A3==A2 && A3!=0) ? WD3:
                  Register[A2];
endmodule
