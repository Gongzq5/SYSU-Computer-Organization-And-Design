`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/29 01:26:13
// Design Name: 
// Module Name: Display
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


module Display(
    input wire [15:0] data,
    input clk,
    output reg [6:0] a_to_g,
    output reg [3:0] dig
    );
    reg [1:0] sel;
    reg [3:0] num;
    initial
        sel = 0;
    always @ (posedge clk )begin
        sel = sel+1;
    end
    
    always @ (sel) begin
        case(sel)
            0: num = data[3:0];
            1: num = data[7:4];
            2: num = data[11:8];
            3: num = data[15:12];
            default: num = data[3:0];
        endcase
    end
        always @ (sel) begin
            case(sel)
            0: dig = 4'b0111;
            1: dig = 4'b1011;
            2: dig = 4'b1101;
            3: dig = 4'b1110;
        endcase
    end
    always @ (num)  begin
        case(num)
            0: a_to_g = 7'b0000001;
            1: a_to_g = 7'b1001111;
            2: a_to_g = 7'b0010010;
            3: a_to_g = 7'b0000110;
            4: a_to_g = 7'b1001100;
            5: a_to_g = 7'b0100100;
            6: a_to_g = 7'b0100000;
            7: a_to_g = 7'b0001111;
            8: a_to_g = 7'b0000000;
            9: a_to_g = 7'b0000100;
            10:a_to_g = 7'b0001000;
            11:a_to_g = 7'b1100000;
            12:a_to_g = 7'b0110001;
            13:a_to_g = 7'b1000010;
            14:a_to_g = 7'b0110000;
            15:a_to_g = 7'b0111000;
            default: a_to_g = 7'b1111111;
        endcase
    end
endmodule
