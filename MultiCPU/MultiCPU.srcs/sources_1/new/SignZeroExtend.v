`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/22 14:53:13
// Design Name: 
// Module Name: SignZeroExtend
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

module SignZeroExtend(
    input [15:0] inData,
    input ExtSel,
    output [31:0] outData
    );
    
    assign outData[31:16] = (ExtSel == 0 ? 16'h0000 : {16{inData[15]}});
    assign outData[15:0] = inData[15:0];
    
endmodule