`timescale 1ns / 1ps

module Alu_riscv(
    input [31:0] a,
    input [31:0] b,
    input [4:0] aluOp,
    output reg flag,
    output reg [31:0] result 
    );
    
    `define ALU_ADD 5'b00000
    `define ALU_SUB 5'b00001 
    `define ALU_XOR 5'b00010
    `define ALU_OR  5'b00011
    `define ALU_AND 5'b00100  
    `define ALU_SRA 5'b00101
    `define ALU_SRL 5'b00110
    `define ALU_SLL 5'b00111
    `define ALU_LTS 5'b01000
    `define ALU_LTU 5'b01001
    `define ALU_GES 5'b01010
    `define ALU_GEU 5'b01011
    `define ALU_EQ  5'b01100
    `define ALU_NE  5'b01101      
    
    always @ (*) begin
        case(aluOp)
            `ALU_ADD : begin result = a + b; flag = 0; end
            `ALU_SUB : begin result = a - b; flag = 0; end
            `ALU_XOR : begin result = a ^ b; flag = 0; end
            `ALU_OR : begin result = a | b; flag = 0; end
            `ALU_AND : begin result = a & b; flag = 0; end
            `ALU_SRA : begin result = a >>> b; flag = 0; end
            `ALU_SRL : begin result = a >> b; flag = 0; end
            `ALU_SLL : begin result = a << b; flag = 0; end
            `ALU_LTS : begin result = $signed(a) < $signed(b); flag = ($signed(a) < $signed(b)); end
            `ALU_LTU : begin result = a < b; flag = (a < b); end
            `ALU_GES : begin result = $signed(a) >= $signed(b); flag = ($signed(a) >= $signed(b)); end
            `ALU_GEU : begin result = a >= b; flag = (a >= b); end
            `ALU_EQ : begin result = a == b; flag = (a == b); end
            `ALU_NE : begin result = a != b; flag = (a != b); end
            default: begin result = 6'hxx; flag = 1'bx; end
        endcase
    end
    
endmodule
