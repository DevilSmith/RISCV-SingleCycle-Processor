`timescale 1ns / 1ps

module RF(
    input clk, //Clock signal
    input we3, //Write Enable 
    input [4:0] a1, //Adress port 1
    input [4:0] a2, //Adress port 2
    input [4:0] a3, //Adress port 3
    input [31:0] wd3, //Write Data
    input rst,
    
    output [31:0] rd1, //Read Data1
    output [31:0] rd2 //Read Data1
    );
    
    //Main register
    reg [31:0] rf [0:31];

    assign rd1 = (a1 != 0) ? rf[a1] : 0;
    assign rd2 = (a2 != 0) ? rf[a2] : 0;   
 
    integer i;

    always @ (posedge clk)
        if (rst) begin 
            for (i=0; i<31; i=i+1)begin
               rf[i] <= 0;
            end
        end 
        else begin
            if (we3) rf[a3] <= wd3;
        end
        

endmodule
