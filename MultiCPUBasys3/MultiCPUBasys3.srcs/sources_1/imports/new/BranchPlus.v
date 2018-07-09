`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/22 14:53:13
// Design Name: 
// Module Name: BranchPlus
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

module BranchPlus(
    input [31:0] OldAddress,
    input [31:0] AddressOffset,
    output reg [31:0] NewAddress
    );
    
    always @ (OldAddress or AddressOffset) begin
        NewAddress = (AddressOffset << 2) + OldAddress;        
    end
    
endmodule