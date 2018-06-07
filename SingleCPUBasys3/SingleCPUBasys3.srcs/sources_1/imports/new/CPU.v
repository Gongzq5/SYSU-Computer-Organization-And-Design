`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/19 21:10:53
// Design Name: 
// Module Name: CPU
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


module CPU(
    input   CLK,
    input   Reset,
    output  [31:0] oPC,
    output  [31:0] onextPC,
    output  [31:0] ors,
    output  [31:0] ort,
    output  [31:0] oReadData1,
    output  [31:0] oReadData2,
    output  [31:0] oResult,
    output  [31:0] oDB
    );
    
    wire [31:0] instruction;
    wire [31:0] Address;
    wire [31:0] oldAddress;
    wire [31:0] PC4;
    wire [31:0] branchAddress;
    wire [31:0] jAddress;
    
    wire [31:0] DB;
    wire [31:0] result;       
    
    wire [31:0] ALUInputA;
    wire [31:0] ALUInputB;
    
    wire [31:0] afterExtend;
    wire [31:0] DataOut;
    wire [31:0] ReadData1;
    wire [31:0] ReadData2;
    
    wire RegDst;
    wire [4:0] WriteReg;    
    wire RegWre;
    wire ALUsrc;
    wire [2:0] ALUop;
    wire [1:0] PCSrc;
    wire ALUSrcA;
    wire ALUSrcB;
    wire mRD;
    wire mWR;
    wire DBDataSrc;
    wire InsMemRW;
    wire PCWre;
    wire ExtSel;
    
    wire zero;
    
    assign oPC = Address;
    assign onextPC = oldAddress;
    
    PC                  pc(CLK, Reset, PCWre, oldAddress, Address);
    PCPlus4             pcplus4(Address, PC4);
    InstructMemory      im(Address, InsMemRW, instruction);
    
    ControlUnit         cu( instruction[31:26],
                            zero,
                            RegDst,
                            RegWre,
                            ALUsrc,
                            ALUop,
                            PCSrc,
                            ALUSrcA,
                            ALUSrcB,
                            mRD,
                            mWR,
                            DBDataSrc,
                            InsMemRW,
                            PCWre,
                            ExtSel);

    Multiplexer2_5      m25(instruction[20:16], instruction[15:11], RegDst, WriteReg);
    
    assign ors = instruction[25:21];
    assign ort = instruction[20:16];
    assign oReadData1 = ReadData1;
    assign oReadData2 = ReadData2;
    
    RegisterFile        rf( CLK, 
                            RegWre, 
                            instruction[25:21], 
                            instruction[20:16], 
                            WriteReg,
                            DB,
                            ReadData1, 
                            ReadData2);
    
    Multiplexer2_32_5   m2325(ReadData1, instruction[10:6], ALUSrcA, ALUInputA);
    
    SignZeroExtend      sze(instruction[15:0], ExtSel, afterExtend);
    
    Multiplexer2_32     m232(ReadData2, afterExtend, ALUSrcB, ALUInputB);
    
    assign oresult = result;
    assign oDB = DB;
    
    ALU                 alu(ALUop, ALUInputA, ALUInputB, zero, result);
    
    DataMemory          dm(CLK, result, ReadData2, mRD, mWR, DataOut);
    
    Multiplexer2_32     m2321(result, DataOut, DBDataSrc, DB);
    
    J_Address           jaddr(PC4, instruction[25:0], jAddress);
    
    BranchPlus          branchplus(PC4, afterExtend, branchAddress);
    
    Multiplexer4_32     m432(PC4, branchAddress, jAddress, PCSrc, oldAddress);
    
endmodule
