`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/22 14:53:13
// Design Name: 
// Module Name: J_Address
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

module J_Address (
    input [31:0] PC4,
    input [25:0] addr,    
    output [31:0] OutAddress
    );
    
    assign OutAddress = {PC4[31:28], addr[25:0], 2'b00};
endmodule