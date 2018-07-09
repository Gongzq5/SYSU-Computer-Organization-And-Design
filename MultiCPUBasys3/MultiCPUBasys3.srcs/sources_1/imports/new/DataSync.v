`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/09 08:28:01
// Design Name: 
// Module Name: DataSync
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


module DataSync (
    input clk,
    input [31:0] iData,
    output [31:0] oData
    );
    
    reg [31:0] oData;

    always @(negedge clk) begin
        oData = iData;
    end
endmodule
