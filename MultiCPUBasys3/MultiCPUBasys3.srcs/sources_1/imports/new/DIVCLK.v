`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/29 01:28:59
// Design Name: 
// Module Name: DIVCLK
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


module DIVCLK(
    input clk,
    output clk_190hz
    );
    
    reg [17:0] q;
    initial begin
        q = 0;
    end
    
    always @ (posedge clk) begin
        q<=q+1;
    end
    
    assign clk_190hz = q[17];
    
endmodule
