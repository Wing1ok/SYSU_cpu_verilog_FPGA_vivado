`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/12 23:11:13
// Design Name: 
// Module Name: mux_5b
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


module mux_5b(
input enable,
input [4:0]data1,
input [4:0]data2,
output [4:0] res
    );
    
    assign res = enable?data2:data1;
endmodule
