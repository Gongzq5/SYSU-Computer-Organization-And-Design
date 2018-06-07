`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/22 14:52:05
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(
    input [5:0] opCode,
    input zero,
    output reg RegDst,
    output reg RegWre,
    output reg ALUsrc,
    output reg [2:0] ALUop,
    output reg [1:0] PCSrc,
    output reg ALUSrcA,
    output reg ALUSrcB,
    output reg mRD,
    output reg mWR,
    output reg DBDataSrc,
    output reg InsMemRW,
    output reg PCWre,
    output reg ExtSel
    );
        
    always@(opCode or zero) begin
        case (opCode)
            // add
            6'b000000:  begin
                            PCWre = 1;
                            ALUSrcA = 0;
                            ALUSrcB = 0;
                            DBDataSrc = 0;
                            RegWre = 1;
                            InsMemRW = 1;
                            mRD = 0;
                            mWR = 0;
                            RegDst = 1;
                            ExtSel = 1;
                            PCSrc = 2'b00;
                            ALUop = 3'b000;
                        end
            // addi
            6'b000001:  begin
                            PCWre = 1;
                            ALUSrcA = 0;
                            ALUSrcB = 1;
                            DBDataSrc = 0;
                            RegWre = 1;
                            InsMemRW = 1;
                            mRD = 0;
                            mWR = 0;
                            RegDst = 0;
                            ExtSel = 1;
                            PCSrc = 2'b00;
                            ALUop = 3'b000;
                        end
            // sub
            6'b000010:  begin
                            PCWre = 1;
                            ALUSrcA = 0;
                            ALUSrcB = 0;
                            DBDataSrc = 0;
                            RegWre = 1;
                            InsMemRW = 1;
                            mRD = 0;
                            mWR = 0;
                            RegDst = 1;
                            ExtSel = 1;
                            PCSrc = 2'b00;
                            ALUop = 3'b001;
                        end
            // ori
            6'b010000:  begin
                            PCWre = 1;
                            ALUSrcA = 0;
                            ALUSrcB = 1;
                            DBDataSrc = 0;
                            RegWre = 1;
                            InsMemRW = 1;
                            mRD = 0;
                            mWR = 0;
                            RegDst = 0;
                            ExtSel = 0;
                            PCSrc = 2'b00;
                            ALUop = 3'b011;
                        end
            // and
            6'b010001:  begin
                            PCWre = 1;
                            ALUSrcA = 0;
                            ALUSrcB = 0;
                            DBDataSrc = 0;
                            RegWre = 1;
                            InsMemRW = 1;
                            mRD = 0;
                            mWR = 0;
                            RegDst = 1;
                            ExtSel = 1;
                            PCSrc = 2'b00;
                            ALUop = 3'b100;
                        end
            // or
            6'b010010:  begin
                            PCWre = 1;
                            ALUSrcA = 0;
                            ALUSrcB = 0;
                            DBDataSrc = 0;
                            RegWre = 1;
                            InsMemRW = 1;
                            mRD = 0;
                            mWR = 0;
                            RegDst = 1;
                            ExtSel = 1;
                            PCSrc = 2'b00;
                            ALUop = 3'b011;
                        end
            // sll
            6'b011000:  begin
                            PCWre = 1;
                            ALUSrcA = 1;
                            ALUSrcB = 0;
                            DBDataSrc = 0;
                            RegWre = 1;
                            InsMemRW = 1;
                            mRD = 0;
                            mWR = 0;
                            RegDst = 1;
                            ExtSel = 1;
                            PCSrc = 2'b00;
                            ALUop = 3'b010;
                        end
            // slti
            6'b011011:  begin
                            PCWre = 1;
                            ALUSrcA = 0;
                            ALUSrcB = 1;
                            DBDataSrc = 0;
                            RegWre = 1;
                            InsMemRW = 1;
                            mRD = 0;
                            mWR = 0;
                            RegDst = 0;
                            ExtSel = 1;
                            PCSrc = 2'b00;
                            ALUop = 3'b110;
                        end
            // sw
            6'b100110:  begin
                            PCWre = 1;
                            ALUSrcA = 0;
                            ALUSrcB = 1;
                            DBDataSrc = 0;
                            RegWre = 0;
                            InsMemRW = 1;
                            mRD = 0;
                            mWR = 1;
                            RegDst = 1;
                            ExtSel = 1;
                            PCSrc = 2'b00;
                            ALUop = 3'b000;
                        end
            // lw
            6'b100111:  begin
                            PCWre = 1;
                            ALUSrcA = 0;
                            ALUSrcB = 1;
                            DBDataSrc = 1;
                            RegWre = 1;
                            InsMemRW = 1;
                            mRD = 1;
                            mWR = 0;
                            RegDst = 0;
                            ExtSel = 1;
                            PCSrc = 2'b00;
                            ALUop = 3'b000;
                        end
            // beq
            6'b110000:  begin
                            PCWre = 1;
                            ALUSrcA = 0;
                            ALUSrcB = 0;
                            DBDataSrc = 0;
                            RegWre = 0;
                            InsMemRW = 1;
                            mRD = 0;
                            mWR = 0;
                            RegDst = 0;
                            ExtSel = 1;                            
                            PCSrc = (zero === 0 ? 2'b00 : 2'b01);
                            ALUop = 3'b001;
                        end
            // bne
            6'b110001:  begin
                            PCWre = 1;
                            ALUSrcA = 0;
                            ALUSrcB = 0;
                            DBDataSrc = 0;
                            RegWre = 1;
                            InsMemRW = 1;
                            mRD = 0;
                            mWR = 0;
                            RegDst = 1;
                            ExtSel = 1;
                            PCSrc = (zero === 1 ? 2'b00 : 2'b01);
                            ALUop = 3'b001;
                        end
            // j
            6'b111000:  begin
                            PCWre = 1;
                            ALUSrcA = 0;
                            ALUSrcB = 0;
                            DBDataSrc = 0;
                            RegWre = 0;
                            InsMemRW = 1;
                            mRD = 0;
                            mWR = 0;
                            RegDst = 0;
                            ExtSel = 1;
                            PCSrc = 2'b10;
                            ALUop = 3'b000;
                        end
            // halt or others
            default:  begin
                            PCWre = 0;
                            ALUSrcA = 0;
                            ALUSrcB = 0;
                            DBDataSrc = 0;
                            RegWre = 0;
                            InsMemRW = 1;
                            mRD = 0;
                            mWR = 0;
                            RegDst = 0;
                            ExtSel = 1;
                            PCSrc = 2'b00;
                            ALUop = 3'b000;
                        end
        endcase
    end
    
endmodule

















