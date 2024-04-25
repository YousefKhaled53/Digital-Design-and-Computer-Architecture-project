module OR1(input logic a, b,
           output logic y);
assign y= a|b;
endmodule


module ORmain(input logic [3:0]x ,[3:0]y,
              output logic[7:0] c );
OR1 op0(x[0] , y[0] , c[0]);
OR1 op1(x[1] , y[1] , c[1]);
OR1 op2(x[2] , y[2] , c[2]);
OR1 op3(x[3] , y[3] , c[3]);
assign c[4] = 0;
assign c[5] = 0;
assign c[6] = 0;
assign c[7] = 0;
endmodule

module NAND1(input logic a, b, output logic y);
assign y= ~(a&b);
endmodule

module NANDmain(input logic [3:0]x ,[3:0]y,
              output logic[7:0] c );
NAND1 op0(x[0] , y[0] , c[0]);
NAND1 op1(x[1] , y[1] , c[1]);
NAND1 op2(x[2] , y[2] , c[2]);
NAND1 op3(x[3] , y[3] , c[3]);
assign c[4] = 0;
assign c[5] = 0;
assign c[6] = 0;
assign c[7] = 0;
endmodule

module XOR1(input logic a, b, output logic y);
assign y= a^b;
endmodule

module XORmain(input logic [3:0]x ,[3:0]y,
              output logic[7:0] c );
XOR1 op0(x[0] , y[0] , c[0]);
XOR1 op1(x[1] , y[1] , c[1]);
XOR1 op2(x[2] , y[2] , c[2]);
XOR1 op3(x[3] , y[3] , c[3]);
assign c[4] = 0;
assign c[5] = 0;
assign c[6] = 0;
assign c[7] = 0;
endmodule

module Adder1(
input logic a,b,cin,
output logic s,cout
);
assign s = a ^ b ^ cin;
assign cout = (a&b) | (b&cin) | (cin&a);
endmodule

module ADDERmain(
input logic [3:0] a , b,
input logic cin,
output logic [7:0] sum,
output logic cout
);

logic c1,c2,c3,c4;

Adder1 op0( a[0], b[0], 0 , sum[0], c1);
Adder1 op1( a[1], b[1], c1 , sum[1], c2);
Adder1 op2( a[2], b[2], c2 , sum[2], c3);
Adder1 op3( a[3], b[3], c3 , sum[3], c4);
assign sum[4] = c4;
assign sum[5] = 0;
assign sum[6] = 0;
assign sum[7] = 0;
assign cout= c4;

endmodule


module MULTmain(
    input logic [3:0] a,
    input logic [3:0] b,
    output logic [7:0] p
);
assign p[0] = a[0] & b[0];

logic[3:0] Anull , Bnull; 
logic[7:0] Sum1;
logic Cout1;

assign Anull[0] = a[0] & b[1];
assign Anull[1] = a[0] & b[2];
assign Anull[2] = a[0] & b[3];
assign Anull[3] = 0;
assign Bnull[0] = a[1] & b[0];
assign Bnull[1] = a[1] & b[1];
assign Bnull[2] = a[1] & b[2];
assign Bnull[3] = a[1] & b[3];

ADDERmain adder1(Anull,Bnull,0,Sum1,Cout1);

assign p[1] = Sum1[0];

logic[3:0] Anull1 , Bnull1;
logic[7:0] Sum2;
logic Cout2;

assign Anull1[0] =  Sum1[1]; 
assign Anull1[1] =  Sum1[2];
assign Anull1[2] =  Sum1[3];
assign Anull1[3] =  Cout1;
assign Bnull1[0] = a[2] & b[0];
assign Bnull1[1] = a[2] & b[1];
assign Bnull1[2] = a[2] & b[2];
assign Bnull1[3] = a[2] & b[3];

ADDERmain adder2(Anull1,Bnull1,0,Sum2,Cout2);

assign p[2] = Sum2[0];

logic[3:0] Anull2 , Bnull2;
logic[7:0] Sum3;
logic Cout3;

assign Anull2[0] =  Sum2[1]; 
assign Anull2[1] =  Sum2[2];
assign Anull2[2] =  Sum2[3];
assign Anull2[3] =  Cout2;
assign Bnull2[0] = a[3] & b[0];
assign Bnull2[1] = a[3] & b[1];
assign Bnull2[2] = a[3] & b[2];
assign Bnull2[3] = a[3] & b[3];

ADDERmain adder3(Anull2,Bnull2,0,Sum3,Cout3);

assign p[3] = Sum3[0];
assign p[4] = Sum3[1];
assign p[5] = Sum3[2];
assign p[6] = Sum3[3];
assign p[7] = Sum3[4];

endmodule

module SUBmain(
input logic [3:0] a , b,
input logic cin,
output logic [7:0] sum,
output logic cout
);

logic c1,c2,c3,c4;

Adder1 op0( a[0], ~b[0], 1 , sum[0], c1);
Adder1 op1( a[1], ~b[1], c1 , sum[1], c2);
Adder1 op2( a[2], ~b[2], c2 , sum[2], c3);
Adder1 op3( a[3], ~b[3], c3 , sum[3], c4);
assign cout= c4;
assign sum[4] = 0;
assign sum[5] = 0;
assign sum[6] = 0;
assign sum[7] = 0;

endmodule



module INCmain(
input logic [3:0] a , b,
input logic cin,
output logic [7:0] sum,
output logic cout
);

logic c1,c2,c3,c4;

Adder1 op0( a[0], 0, 1, sum[0], c1);
Adder1 op1( a[1], 0, c1, sum[1], c2);
Adder1 op2( a[2], 0, c2, sum[2], c3);
Adder1 op3( a[3], 0, c3, sum[3], c4);
assign sum[4] = c4;
assign cout= c4;
assign sum[5] = 0;
assign sum[6] = 0;
assign sum[7] = 0;
endmodule

module SHIFTmain(
    input logic [3:0] a,
    output logic [7:0] shifted
);
       assign shifted[0] = a[1]; 
    assign shifted[1] = a[2]; 
    assign shifted[2] = a[3];
    assign shifted[3] = 0;
assign shifted[4] = 0;
assign shifted[5] = 0;
assign shifted[6] = 0;
assign shifted[7] = 0;
endmodule

module MUXmain(
    input logic [2:0] selector,
    input logic [3:0] a,
    input logic [3:0] b,
    output logic [7:0] y
);
    logic [7:0] adder_sum;
    logic adder_cout;

    ADDERmain adder_inst (
        a,
        b,
        selector[0],
        adder_sum,
        adder_cout
    );

    logic [7:0] inc_sum;
    logic inc_cout;

    INCmain inc_inst (
        a,
        b,
        1,
        inc_sum,
        inc_cout
    );

    logic [7:0] sub_sum;
    logic sub_cout;

    SUBmain sub_inst (
        a,
        b,
        1,
        sub_sum,
        sub_cout
    );

    logic [7:0] or_out, nand_out, xor_out;

    ORmain or_inst(
        a,
        b,
        or_out
    );

    NANDmain nand_inst(
        a,
        b,
        nand_out
    );

    XORmain xor_inst(
        a,
        b,
        xor_out
    );

    logic [7:0] shifted_out;

    SHIFTmain shift_inst (
        a,
        shifted_out
    );

    logic [7:0] mult_product;

    MULTmain mult_inst (
        a,
        b,
        mult_product
    );

    assign y = (selector == 3'b000) ? or_out :
              (selector == 3'b001) ?  nand_out :
              (selector == 3'b010) ?  xor_out :
              (selector == 3'b011) ?  mult_product :
              (selector == 3'b100) ? adder_sum:
              (selector == 3'b101) ?  inc_sum :
              (selector == 3'b110) ?  sub_sum :
              (selector == 3'b111) ? shifted_out :
              8'b0;
endmodule 

module ALUmain(input logic [3:0] a , b , input logic [2:0] selector , output logic [7:0] y);
MUXmain OPmain(selector , a , b ,  y);
endmodule

module ALUmain_TB;

    logic [3:0] a, b;
    logic [2:0] selector;
    logic [7:0] y,p,s;

    ALUmain dut (
        a,
        b,
        selector,
        y
    );
	MULTmain mt(
	a,
	b,
	p
	);

NANDmain nd(
a,
b,
s);



    // Test case 1: a = 0011, b = 0101
    initial begin
        $display("Test Case 1:");
        a = 4'b0110;
        b = 4'b1011;
        selector = 3'b000; // OR
        #10; $display("OR: %b", y);

        selector = 3'b001; // NAND
        #10; $display("NAND: %b", y);

        selector = 3'b010; // XOR
        #10; $display("XOR: %b", y);

        selector = 3'b011; // Multiplier
        #10; $display("Multiplier: %b", y);

        selector = 3'b100; // Adder
        #10; $display("Adder: %b", y);

        selector = 3'b101; // Inc
        #10; $display("INC: %b", y);

        selector = 3'b110; // Subtraction
        #10; $display("Subtraction: %b", y);

        selector = 3'b111; // Shift
        #10; $display("Shift: %b", y);

        #10; $display(""); // Empty line to separate test cases
  	
	$display("Test Case 2:");
        a = 4'b1011;
        b = 4'b0111;
        #10; $display("Multiplier Test Case: %b", p);
	#10; $display(""); // Empty line to separate test cases

	$display("Test Case 3:");
        a = 4'b1011;
        b = 4'b0101;
        #10; $display("NAND Test Case: %b", s);
        #10; $finish;
    end

endmodule