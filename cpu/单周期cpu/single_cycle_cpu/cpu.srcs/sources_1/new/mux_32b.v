`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/12 23:18:44
// Design Name: 
// Module Name: mux_32b
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


module mux_32b(
input enable,
input [31:0]data1,
input [31:0]data2,
output [31:0] res
    );
    
    assign res=enable?data1:data2;
endmodule
