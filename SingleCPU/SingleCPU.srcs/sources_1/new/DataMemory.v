`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/19 21:10:53
// Design Name: 
// Module Name: DataMemory
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


module DataMemory(
    input CLK,
    input [31:0] address,
    input [31:0] writeData, // [31:24], [23:16], [15:8], [7:0]
    input nRD, // �?�?正常读； �?,输出高组�?
    input nWR, // �?�?写； �?�?无操�?
    output [31:0] Dataout
    );
    
    reg [7:0] ram [0:60]; // 存储器定义必须用reg类型
    
    // �?
    assign Dataout[7:0] = (nRD==1)?ram[address + 3]:8'bz; // z 为高阻�?
    assign Dataout[15:8] = (nRD==1)?ram[address + 2]:8'bz;
    assign Dataout[23:16] = (nRD==1)?ram[address + 1]:8'bz;
    assign Dataout[31:24] = (nRD==1)?ram[address ]:8'bz;
    
    // �?
    always@( negedge CLK ) begin // 用时钟下降沿触发写存储器�?个例
        if( nWR == 1 ) begin
            ram[address] = writeData[31:24];
            ram[address+1] = writeData[23:16];
            ram[address+2] = writeData[15:8];
            ram[address+3] = writeData[7:0];
        end
    end
    
endmodule
