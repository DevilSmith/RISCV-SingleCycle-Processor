`timescale 1ns / 1ps

`include "instruction_memory.v"
`include "ALU_RISCV.v"
`include "RF.v"

module microarchitecture();

    wire [31:0] instr;
    wire clk;
    wire rst;
    
    wire we3;
    assign we3 = instr[29] | instr [28];
    
    wire [31:0] rd1;
    wire [31:0] rd2;
    reg [31:0] wd3;
    
    reg [7:0] pc;
    
    wire [31:0] aluResult;
    wire flag;
   
    
    wire [1:0] pcOp;
    assign pcOp = ((flag & instr[30])) | instr[31];
    reg [31:0] pcInput;
    
    //Work with program counter
    always @ (*) begin
        case(pcOp)
            2'b0: begin pcInput = 8'h1; end
            2'b1: begin pcInput = instr[12:5]; end
        endcase    
    end
    
    //Increase program counter
    always @ (posedge clk) begin
        pc <= pc + pcInput;
    end

    //Reset program counter
    always @ (posedge rst) begin
        pc <= 0;
    end
    
    //Instantiation of modules ALU, RF, Instruction memory
    instruction_memory IM (pc, instr);
    RF finalRF(clk, we3, instr[22:18], instr[17:13], instr[4:0], wd3, rst, rd1, rd2);
    Alu_riscv ALU(rd1, rd2, instr[27:23], flag, aluResult);
    
    //Work with write data
    wire [1:0] wdOp;
    assign wdOp = instr[29:28];
    wire [31:0] seConst = {{24{instr[12]}}, instr[12:5]}; // <--- SE block realization
    
    always @ (*) begin
        case(wdOp)
            2'b10: begin assign wd3 = aluResult; end
            2'b11: begin assign wd3 = seConst; end
        endcase
    end
    
endmodule
