`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/22 14:53:13
// Design Name: 
// Module Name: Multiplexer2_32_5
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

module Multiplexer2_32_5 (
    input [31:0] select_0,
    input [4:0] select_1,
    input selection,
    output [31:0] OutAddress
    );

    assign OutAddress = (selection == 0 ? select_0 : {27'b000000000000000000000000000 , select_1});
    
endmodule