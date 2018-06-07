`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/19 21:14:32
// Design Name: 
// Module Name: PC
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


module PC(
    input clk,
    input reset,
    input PCWre,
    input [31:0] Address,
    output reg [31:0] outAddress
    );
    
    always @ (posedge clk or posedge reset) 
    begin
        if (reset == 1) begin
            outAddress = 0;
        end
        else begin
            if (PCWre == 1) begin
                outAddress = Address;     
            end else begin
                outAddress = outAddress;
            end
        end
    end
    
endmodule
