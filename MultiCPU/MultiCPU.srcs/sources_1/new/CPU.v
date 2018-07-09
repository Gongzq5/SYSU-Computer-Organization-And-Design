`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/09 08:22:49
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
    input CLK,
    input Reset
    );

	wire [31:0] instruction, Address, oldAddress, PC4, branchAddress,
                jAddress, DB, result, ALUInputA, ALUInputB,    
                afterExtend, DataOut, ReadData1, ReadData2, 
                IRinput, WriteData, ADROut, BDROut, DAddr, DBDRin;
    
    wire [1:0] RegDst;
    wire [4:0] WriteReg;    
    wire [2:0] ALUop;
    wire [1:0] PCSrc;
    wire RegWre, ALUSrcA, ALUSrcB, mRD, mWR, DBDataSrc, InsMemRW, WrRegDSrc, 
         PCWre, ExtSel, zero, IRWre, ReadData1n, ReadData2n, sign;

    assign op = instruction[31:26];
    assign rs = instruction[25:21];
    assign rt = instruction[20:16];
    assign rd = instruction[15:11];
    assign sa = instruction[10:6];
    assign immi = instruction[15:0];
    assign addr = instruction[25:0];

    PC                  pc(CLK, Reset, PCWre, oldAddress, Address);
    PCPlus4             pcplus4(Address, PC4);
    InstructMemory      im(Address, InsMemRW, IRinput);
    
    IR                  ir(CLK, IRinput, IRWre, instruction);

    ControlUnit         cu( CLK, Reset, zero, sign, op, PCWre, ALUSrcA,
                            ALUSrcB, DBDataSrc, RegWre, WrRegDSrc, InsMemRW,
                            mRD, mWR, IRWre, ExtSel, PCSrc, RegDst, ALUop);

    Multiplexer4_32     WriteRegSelector(5'b11111, rt, rd, 5'b00000, RegDst, WriteReg);
    
    Multiplexer2_32     WriteDataSelector(PC4, DB, WrRegDSrc, WriteData);

    RegisterFile        rf( CLK, RegWre, rs, rt, WriteReg, 
                            WriteData, ReadData1, ReadData2); 

    DataSync 			adr(CLK, ReadData1, ADROut);
    DataSync            bdr(CLK, ReadData2, BDROut);

    Multiplexer2_32_5   ALUASelector(ADROut, sa, ALUSrcA, ALUInputA);
    
    SignZeroExtend      sze(immi, ExtSel, afterExtend);
    
    Multiplexer2_32     ALUBSelector(BDROut, afterExtend, ALUSrcB, ALUInputB);    

    ALU                 alu(ALUop, ALUInputA, ALUInputB, zero, sign, result);
    
    ALUoutDR 			aluoutdr(CLK, result, DAddr);

    DataMemory          dm(CLK, DAddr, BDROut, mRD, mWR, DataOut);
    
    Multiplexer2_32     DBDRSelector(result, DataOut, DBDataSrc, DBDRin);

    DataSync 			dbdr(CLK, DBDRin, DB);
    
    J_Address           jaddr(PC4, addr, jAddress);
    
    BranchPlus          branchplus(PC4, afterExtend, branchAddress);
    
    Multiplexer4_32     PCSelector(PC4, branchAddress, ReadData1, jAddress, PCSrc, oldAddress);

endmodule
