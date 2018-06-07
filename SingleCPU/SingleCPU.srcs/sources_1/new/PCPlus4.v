`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/22 14:53:13
// Design Name: 
// Module Name: PCPlus4
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

module PCPlus4(
    input [31:0] OldAddress,
    output reg [31:0] NewAddress
    );
    
    initial begin
        NewAddress = 0;
    end
    
    always @ (OldAddress) begin
        NewAddress = (OldAddress + 4);
    end
    
endmodule