`timescale 1ns / 1ps
`include "microarchitecture.v"

module microarchitecture_tb();

    reg [31:0] sw = 32'd13;

    reg clk = 1'b1;
    always #1 clk = !clk;

    reg rst = 1'b1;
    
    wire [31:0] out;

    microarchitecture microarchitecture(clk, rst, sw, out);

    initial begin
        rst = 1'b1;
        #10
        rst = 1'b0;
        $dumpfile("RESULT.vcd");
        $dumpvars;
        #4000
        $display("Result: ", out);
        $finish;
    end
endmodule