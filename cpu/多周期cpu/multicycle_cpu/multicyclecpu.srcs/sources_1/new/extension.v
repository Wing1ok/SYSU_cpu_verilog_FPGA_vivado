`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/12 22:13:11
// Design Name: 
// Module Name: extension
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


module extension(
input extsel,
input [15:0] immediate,
output [31:0] res
    );
    
    assign res ={extsel&&immediate[15]?16'hffff:16'h0000,immediate};
endmodule
