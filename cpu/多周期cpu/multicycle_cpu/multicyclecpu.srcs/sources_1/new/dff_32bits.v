`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/10 15:50:56
// Design Name: 
// Module Name: dff_32bits
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


module dff_32bits(
input clk,
input reset,
input [31:0]in,
output reg [31:0]out
    );
    
    always @(posedge clk or negedge reset)begin
    if(reset==0)out<=0;
    else out<=in;
    end
endmodule
