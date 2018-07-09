`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/22 14:52:05
// Design Name: 
// Module Name: NextStateProductor
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


module NextStateProductor(
    input [2:0] iState,
    input [5:0] opCode,
    output [2:0] state
    );
    
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

    initial begin
        stated = sIF;
    end

    // 状态转移
    always @(iState or opCode) begin
        case (iState) begin
            sIF: state = sID;
            sID: 
                if (opCode == j_op || 
                    opCode == jal_op ||
                    opCode == jr ||
                    opCode == halt) begin
                    state = sIF;
                end
                else begin
                    state = sEXE;
                end
            sEXE:
                if (opCode == beq_op ||
                    opCode == bltz_op) begin
                    state = sIF;        
                end
                else if (opCode == sw ||
                         opCode == lw) begin
                    state = sMEM;
                end
                else begin
                    state = sWB;
                end
            sMEM:
                if (opCode == sw) begin
                    state = sIF;
                end
                else begin
                    state = lw;
                end
            sWB: state = sIF;
            default: state = sIF;
        endcase
    end

endmodule