`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/10 18:27:57
// Design Name: 
// Module Name: mux4_5bits
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux4_5bits(
input [1:0]choice,
input [4:0]in0,in1,in2,in3,
output reg [4:0]out
    );
    
    always @(*)begin
    case(choice)
    0:out<=in0;
    1:out<=in1;
    2:out<=in2;
    3:out<=in3;
    endcase
    end
endmodule
