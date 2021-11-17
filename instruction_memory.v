`timescale 1ns / 1ps


module instruction_memory(
    input [7:0] a,
    output [31:0] rd
    );
    
    initial $readmemb("file_name", reg_name);
    reg [31:0] reg_name [63:0];
    
    assign rd = reg_name[a];
    
endmodule
