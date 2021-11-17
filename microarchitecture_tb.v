`timescale 1ns / 1ps
`include "microarchitecture.v"

module microarchitecture_tb();

    reg clk = 1'b0;
    always #5 clk = !clk;

    reg rst = 1'b0;

    microarchitecture microarchitecture(clk, rst);

    initial begin
        $dumpfile("microarchitecture_tb.vcd");
        $dumpvars;
        #4 $finish;
    end
endmodule