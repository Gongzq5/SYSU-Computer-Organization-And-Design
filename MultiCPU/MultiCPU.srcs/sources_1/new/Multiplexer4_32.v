`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/22 14:53:13
// Design Name: 
// Module Name: Multiplexer4_32
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

module Multiplexer4_32(
    input [31:0] select_0,
    input [31:0] select_1,
    input [31:0] select_2,
    input [31:0] select_3,
    input [1:0] selection,
    output [31:0] OutAddress
    );
	
	assign OutAddress = (selection == 2'b00 ? select_0 : 
						(selection == 2'b01 ? select_1 : 
						(selection == 2'b10 ? select_2 :
						(selection == 2'b11 ? select_3))));
    
endmodule