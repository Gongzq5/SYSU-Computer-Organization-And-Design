`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/29 08:20:03
// Design Name: 
// Module Name: simForFPGA
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


module simForFPGA;
    reg clk;
    reg step;
    reg Reset;
    reg [1:0] Sel;
    wire [6:0] atog;
    wire [3:0] enlight;
        
    initial begin
        clk = 0;
        step = 0;
        Reset = 1;
        Sel = 2'b00;
        #5
        Reset = 0;
    end
       
    always #10 begin
        clk = ~clk;
    end
    

    top t(clk, step, Reset, Sel, atog, enlight);
    
endmodule
