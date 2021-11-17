`timescale 1ns / 1ps

module testbench();

//ALU Input
reg [31:0] a;
reg [31:0] b;
reg [4:0] aluOp;

wire [31:0] result;
wire flag;


//RegFile input
    reg clk; //Clock signal
    reg we3; //Write Enable 
    reg [4:0] a1; //adress 1
    reg [4:0] a2; //adress 2
    reg [4:0] a3; //adress 3
    reg [31:0] wd3; //Write Data
    
    wire [31:0] rd1; //Read Data1
    wire [31:0] rd2; //Read Data1
    
    
    always #5 clk = !clk;

//     assign ALU_ADD = 6'b011000;
//     assign ALU_SUB = 6'b011001;
//     assign ALU_XOR = 6'b101111;
//     assign ALU_OR =  6'b101110;
//     assign ALU_AND = 6'b010101;   
//     assign ALU_SRA = 6'b100100;
//     assign ALU_SRL = 6'b100101;
//     assign ALU_SLL = 6'b100111;
//     assign ALU_LTS = 6'b000000;
//     assign ALU_LTU = 6'b000001; 
//     assign ALU_GES = 6'b001010;
//     assign ALU_GEU = 6'b001011;
//     assign ALU_EQ = 6'b001100; 
//     assign ALU_NE = 6'b001101;  

Alu_riscv testAlu(a,b,aluOp,flag,result);

RF testRF(clk,we3,a1,a2,a3,wd3,1,rd1,rd2);



initial begin

    //ALU_ADD Test
    a = 32'h1; b = 32'h2;  aluOp = 5'b00000;
    #10
    if (result == 32'h3 && flag == 1'h0)
        $display("ALU_ADD no error");
    else 
        $display("AlU_ADD have error!"); #10;


    //ALU_SUB Test
    a = 32'h3; b = 32'h2;  aluOp = 5'b00001;
    #10
    if (result == 32'h1 && flag == 1'h0)
        $display("ALU_SUB no error");
    else 
        $display("AlU_SUB have error!"); #10;


    //ALU_XOR Test
    a = 1'b1; b = 1'b1;  aluOp = 5'b00010;
    #10
    if (result == 1'b0 && flag == 1'h0)
        $display("ALU_XOR no error");
    else 
        $display("AlU_XOR have error!"); #10;


    //ALU_OR Test
    a = 1'b1; b = 1'b0;  aluOp = 5'b00011;
    #10
    if (result == 1'b1 && flag == 1'h0)
        $display("ALU_OR no error");
    else 
        $display("AlU_OR have error!"); #10;


    //ALU_AND Test
    a = 1'b1; b = 1'b0;  aluOp = 5'b00100 ;
    #10
    if (result == 1'b0 && flag == 1'h0)
        $display("ALU_AND no error");
    else 
        $display("AlU_AND have error!"); #10;


    //ALU_SRA Test
    a = 3'b001; b = 3'b000;  aluOp = 5'b00101;
    #10
    if (result == 3'b001 && flag == 1'h0)
        $display("ALU_SRA no error");
    else 
        $display("AlU_SRA have error!"); #10;


    //ALU_SRL Test
    a = 3'b001; b = 3'b000;  aluOp = 5'b00110;
    #10
    if (result == 3'b001 && flag == 1'h0)
        $display("ALU_SRL no error");
    else 
        $display("AlU_SRL have error!"); #10;



    //ALU_SLL Test
    a = 3'b001; b = 3'b000;  aluOp = 5'b00111;
    #10
    if (result == 3'b001 && flag == 1'h0)
        $display("ALU_SLL no error");
    else 
        $display("AlU_SLL have error!"); #10;



    //ALU_LTS Test
    a = 32'h5; b = 32'h10;  aluOp = 5'b01000;
    #10
    if (result == 1'b1 && flag == 1'b1)
        $display("ALU_LTS no error");
    else 
        $display("AlU_LTS have error!"); #10;


    //ALU_LTU Test
    a = 32'h5; b = -32'h10;  aluOp = 5'b01001;
    #10
    if (result == 1'b1 && flag == 1'b1)
        $display("ALU_LTU no error");
    else 
        $display("AlU_LTU have error!"); #10;


    //ALU_GES Test
    a = 32'h5; b = 32'h5;  aluOp = 5'b01010;
    #10
    if (result == 1'b1 && flag == 1'b1)
        $display("ALU_GES no error");
    else 
        $display("AlU_GES have error!"); #10;


    //ALU_GEU Test
    a = -32'h5; b = 32'h5;  aluOp = 5'b01011;
    #10
    if (result == 1'b1 && flag == 1'b1)
        $display("ALU_GEU no error");
    else 
        $display("AlU_GEU have error!"); #10;


    //ALU_EQ Test
    a = 32'h10; b = 32'h10;  aluOp = 5'b01100;
    #10
    if (result == 1'b1 && flag == 1'b1)
        $display("ALU_EQ no error");
    else 
        $display("AlU_EQ have error!"); #10;


    //ALU_NE Test
    a = 32'h5; b = 32'h10;  aluOp = 5'b01101 ;
    #10
    if (result == 1'b1 && flag == 1'b1)
        $display("ALU_NE no error");
    else 
        $display("AlU_NE have error!"); #100;


    //RegFile Test
    wd3 = 32'h40; a3 = 4'h2; a1 = 4'h2; we3 = 1;
    #10

    if(rd1[a1] == 32'h40) begin
        $display("RegFile no error"); 
        $display("rd1: ",rd1[a3]); 
        $display("wd3: ",wd3); 
    end
    else
        $display("RegFile have error !"); #10;

end

endmodule
