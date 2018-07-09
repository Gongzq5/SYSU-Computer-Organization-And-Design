`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/22 14:52:05
// Design Name: 
// Module Name: Dtrigger
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


module Dtrigger(
    input clk,
    input rst,
    input [2:0] iState,
    output [2:0] oState
    );
    
    reg [2:0] oState;

    initial begin
        oState = 3'b000;
    end

    always @(negedge clk or posedge rst) begin
        if (rst) begin
            oState = 3'b000;
        end
        else begin
            oState = iState;
        end
    end

endmodule

















