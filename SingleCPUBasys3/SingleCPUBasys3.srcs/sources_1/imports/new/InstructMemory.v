`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/22 14:52:05
// Design Name: 
// Module Name: InstructMemory
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


module InstructMemory(
    input wire [31:0] iAddr,
    input RW,
    output reg [31:0] dataOut
    );
    
    reg [7:0] rom [0:99];
    
    initial begin
        $readmemb("H:/Vivado/VivadoProject/SingleCPU/SingleCPU.srcs/sources_1/new/instruction.txt", rom, 0);
    end
   
    always @( RW or iAddr ) begin
        if (RW == 1) begin
            dataOut[31:24] = rom[iAddr];
            dataOut[23:16] = rom[iAddr+1];
            dataOut[15:8] = rom[iAddr+2];
            dataOut[7:0] = rom[iAddr+3];
        end
    end
endmodule