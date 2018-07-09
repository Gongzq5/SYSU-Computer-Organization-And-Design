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
    input clk,
    input rst,
    input zero,
    input sign,
    input [5:0] opCode,
    output reg PCWre,
    output reg ALUSrcA,
    output reg ALUSrcB,
    output reg DBDataSrc,
    output reg RegWre,
    output reg WrRegDSrc,
    output reg InsMemRW,
    output reg mRD,
    output reg mWR,
    output reg IRWre,
    output reg ExtSel
    output reg [1:0] PCSrc,
    output reg [1:0] RegDst,
    output reg [2:0] ALUop,
    );
    
    reg [2:0] state;
    wire [2:0] innerState;
    initial begin
        state = 3'b000;
    end

    parameter[5:0] add_op  = 6'b000000,
                   sub_op  = 6'b000001,
                   addi_op = 6'b000010,
                   or_op   = 6'b010000,
                   and_op  = 6'b010001,
                   ori_op  = 6'b010010,
                   sll_op  = 6'b011000,
                   slt_op  = 6'b100110,
                   sltiu_op= 6'b100111,
                   slti_op = 6'b011011,
                   sw_op   = 6'b110000,
                   lw_op   = 6'b110001,
                   beq_op  = 6'b110100,
                   bne_op  = 6'b110001,
                   bltz_op = 6'b110110,
                   j_op    = 6'b111000,
                   jr_op   = 6'b111001,
                   jal_op  = 6'b111010,
                   halt_op = 6'b111111;

    parameter[2:0] sIF  = 3'b000,
                   sID  = 3'b001,
                   sEXE = 3'b010,
                   sMEM = 3'b100,
                   sWB  = 3'b011;

    Dtrigger dtrigger(clk, rst, innerState, state);
    NextStateProductor statechanger(state, opCode, innerState);
    
    // 控制信号
    always @(state) begin

        // PCWre
        if (state == sIF && opCode != halt_op) begin
            PCWre = 1;
        end else begin
            PCWre = 0;
        end
        
        // ALUSrcA
        if (opCode == sll_op) begin
            ALUSrcA = 1;
        end else begin
            ALUSrcA = 0;
        end
        
        // ALUSrcB
        if (opCode == addi_op || 
            opCode == ori_op ||
            opCode == sltiu_op || 
            opCode == lw_op ||
            opCode == sw_op) begin
            ALUSrcB = 1;
        end else begin
            ALUSrcB = 0;
        end

        // DBDataSrc
        if (opCode == lw_op) begin
            DBDataSrc = 1;
        end else begin
            DBDataSrc = 0;
        end

        // RegWre
        if (state != sWB || (opCode == beq_op ||
                             opCode == bltz_op ||
                             opCode == j_op ||
                             opCode == sw_op ||
                             opCode == jr_op ||
                             opCode == halt_op)) begin
            RegWre = 0;     
        end else begin
            RegWre = 1;
        end

        // WrRegDSrc
        if (opCode == jal_op) begin
            WrRegDSrc = 0;
        end else begin
            WrRegDSrc = 1;
        end

        // InsMemRW
        InsMemRW = 1;

        // mRD
        if (opCode == lw_op) begin
            mRD = 1;
        end else begin
            mWR = 0;
        end

        // mWR
        if (opCode == sw_op) begin
            mWR = 1;
        end else begin
            mWR = 0;
        end

        // IRWre
        if (state == sIF) begin
            IRWre = 1;
        end else begin
            IRWre = 0;
        end

        // ExtSel
        if (opCode == ori_op ||
            opCode == sltiu_op) begin
            ExtSel = 0;
        end else begin
            ExtSel = 1;
        end

        // PCSrc[1:0]
        if (opCode == jr_op) begin
            PCSrc = 2'b10;
        end 
        else if ((opCode == beq_op && zero == 1) ||
        (opCode == bltz_op && sign == 1 && zero == 0)) begin
            PCSrc = 2'b01;    
        end
        else if (opCode == j_op ||
                 opCode == jal_op) begin
            PCSrc = 2'b11;
        end
        else begin
            PCSrc = 2'b00;
        end

        // RegDst[1:0]
        if (opCode == jal_op) begin
            RegDst = 2'b00;
        end 
        else if (opCode == addi_op ||
                 opCode == ori_op ||
                 opCode == sltiu_op ||
                 opCode == lw_op) begin
            RegDst = 2'b01;
        end
        else begin
            RegDst = 2'b10;
        end

        // ALUop[2:0]
        if (opCode == and_op) begin
            ALUop = 3'b110;
        end else if (opCode == or_op ||
                     opCode == ori_op) begin
            ALUop = 3'b101;
        end else if (opCode == sll_op) begin
            ALUop = 3'b100;    
        end else if (opCode == bltz_op ||
                     opCode == slti_op ||
                     opCode == slt_op) begin
            ALUop = 3'b011;
        end else if (opCode == sltiu_op) begin
            ALUop = 3'b010;
        end else if (opCode == sub_op ||
                     opCode == beq_op ||
                     opCode == bne_op) begin
            ALUop = 3'b001;
        end else begin
            ALUop = 3'b000;
        end

        // 防止在IF阶段写数据
        if (state == sIF) begin
            RegWre = 0;
            DataMemRW = 0;
        end
    end

endmodule
