`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 00:54:44
// Design Name: 
// Module Name: Multi_sim
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


module Multi_sim;

    reg clk;
    reg reset;
    
    CPU cpu(clk, reset);
    
    initial begin
        clk = 0;
        reset = 1;
        
        #5
        reset = 0; 
    end 
    
    
    always #10 begin
        clk <= ~clk;        
    end
    
endmodule
