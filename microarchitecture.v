`timescale 1ns / 1ps

`include "instruction_memory.v"
`include "ALU_RISCV.v"
`include "RF.v"

module microarchitecture(
    input clk,
    input rst,
    input [31:0] sw,

    output [31:0] out
);

    wire [31:0] instr; //All instruction

    //Write enable
    wire we3; 
    assign we3 = instr[29] | instr [28]; 
    
    wire [31:0] rd1; //Read data from RF port 1
    wire [31:0] rd2; //Read data from RF port 2
    reg [31:0] wd3; //Write data from RF port 3
    
    reg [7:0] pc; //Register for Program Counter
    
    wire [31:0] aluResult; //ALU result
    wire flag; //ALU flag

    assign out = aluResult[31:0];
   
    wire [1:0] pcOp;
    assign pcOp = ((flag & instr[30])) | instr[31];
    reg [7:0] pcInput;
    
    //Work with program counter
    always @ (*) begin
        case(pcOp)
            2'b0: begin pcInput = 8'h1; end
            2'b1: begin pcInput = instr[12:5]; end
        endcase    
    end
    
    //Increase program counter
    always @ (posedge clk | rst) begin
        if (rst) begin
            pc <= 0;
        end
        else begin
            pc <= pc + pcInput;
        end
    end
    
    //Instantiation of modules ALU, RF, Instruction memory
    instruction_memory IM (pc, instr);
    RF finalRF(clk, we3, instr[22:18], instr[17:13], instr[4:0], wd3, rst, rd1, rd2);
    Alu_riscv ALU(rd1, rd2, instr[27:23], flag, aluResult);
    
    //Work with write data
    wire [1:0] wdOp = instr[29:28];
    wire [31:0] seConst = {{9{instr[27]}}, instr[27:5]}; //SE 
    
    //Multiplexor for write register file
    always @ (*) begin
        case(wdOp)
            2'd1: begin assign wd3 = sw; end
            2'd3: begin assign wd3 = aluResult; end
            2'd2: begin assign wd3 = seConst; end
        endcase
    end
    
endmodule
