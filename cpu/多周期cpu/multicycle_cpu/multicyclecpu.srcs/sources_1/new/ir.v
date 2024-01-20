`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/10 15:45:14
// Design Name: 
// Module Name: ir
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


module ir(
input clk,
input irwre,
input [31:0]insin,
output reg [31:0]insout
    );
    always @(negedge clk)begin
    if(irwre==0) insout<=insin;
    else insout<=insout;
    end
endmodule
