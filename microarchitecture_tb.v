`timescale 1ns / 1ps
`include "microarchitecture.v"

module microarchitecture_tb();

    reg clk = 1'b1;
    always #1 clk = !clk;

    reg rst = 1'b1;
    
    wire [31:0] out;

    microarchitecture microarchitecture(clk, rst, out);

    initial begin
        rst = 1'b0;
        $dumpfile("microarchitecture_tb.vcd");
        $dumpvars;
        #128 $finish;
    end
endmodule