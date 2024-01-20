`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/14 14:14:35
// Design Name: 
// Module Name: mux4_32bits
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


module mux4_32bits(
input [1:0]choice,
input [31:0]in0,
input [31:0]in1,
input [31:0]in2,
input [31:0]in3,
output reg [31:0]out
    );
    
    always @(choice or in0 or in1 or in2 or in3)begin
    case (choice)
    2'b00:out=in0;
    2'b01:out=in1;
    2'b10:out=in2;
    2'b11:out=in3;
    default:out=0;
    endcase
    end
endmodule
