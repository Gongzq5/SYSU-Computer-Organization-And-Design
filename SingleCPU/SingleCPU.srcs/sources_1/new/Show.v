`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/29 01:31:40
// Design Name: 
// Module Name: Show
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Show( Sel, PC, NextPC ,rs, ReadData1, rt, ReadData2, Result, DB, Out);
    input [1:0] Sel;
    input [4:0] rs, rt;
    input [31:0]  PC, NextPC, ReadData1, ReadData2, Result, DB;
    output reg [15:0] Out;
    
    always @ (*) begin
        case(Sel)
            0: begin
                Out[15:8] = PC[7:0];
                Out[7:0] = NextPC[7:0];
            end
            1: begin
                Out[15:8] = {3'b000,rs[4:0]};
                Out[7:0] = ReadData1[7:0];
            end
            2: begin
                Out[15:8] = {3'b000,rt[4:0]};
                Out[7:0] = ReadData2[7:0];
            end
            3: begin
                Out[15:8] = Result[7:0];
                Out[7:0] = DB[7:0];
            end
        endcase
    end
endmodule
