`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/26 20:37:50
// Design Name: 
// Module Name: CPUtest
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


module CPUtest;
    
    reg clk;
    reg reset;
    
    CPU cpu(clk, reset);
    
    initial begin
        clk = 1;
        reset = 1;
        
        #5
        reset = 0; 
    end 
    
    
    always #10 begin
        clk <= ~clk;        
    end
    
endmodule
