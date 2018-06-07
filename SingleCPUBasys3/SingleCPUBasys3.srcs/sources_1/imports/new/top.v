`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/29 01:33:08
// Design Name: 
// Module Name: top
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


module top(
    input clk,
    input step,
    input Reset,
    input [1:0] Sel,
    output [6:0] atog,
    output [3:0] enlight
    );
    
    wire clk190hz,key_out,zero, sign, PCWre, ALUSrcA, ALUSrcB, DBDataSrc,
    RegWre, InsMemRW, RD, WR, ExtSel, RegDst;
    wire [1:0] PCSrc;
    wire [2:0] ALUOp;
    wire [4:0] rs, rd, rt, sa, regwrite;
    wire [5:0] Opcode;
    wire [15:0] data;
    wire [31:0] Pc, nextPC, Regdata1, Regdata2, WRegdata, Result, ExtOut, Jpc,
    Ramout, dataA, dataB, reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7,
    reg8, reg9;
    
    
    DIVCLK div(clk, clk190hz);
    KeyDown key(clk190hz, step, key_out);
    Show show(Sel, Pc, nextPC, rs, Regdata1, rt, Regdata2, Result, WRegdata, data);
    
    Display hex(data, clk190hz, atog, enlight);
    
    CPU cputop(key_out, Reset, Pc, nextPC, rs, rt, Regdata1, Regdata2, Result, data);

endmodule
