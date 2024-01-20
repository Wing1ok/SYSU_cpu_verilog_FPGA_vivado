`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/17 17:43:59
// Design Name: 
// Module Name: sim_pc
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


module sim_pc(

    );
    reg clk;
    reg reset;
    reg pcwre;
    reg new_addr;
    reg pc;
    
    pc c(
    .clk(clk),
    .reset(reset),
    .pcwre(pcwre),
    .new_addr(new_addr)
    );
endmodule
