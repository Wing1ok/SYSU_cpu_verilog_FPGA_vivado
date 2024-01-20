`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/17 18:47:53
// Design Name: 
// Module Name: pc_sim
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


module pc_sim(

    );
    
reg clk;
reg reset;
reg pcwre;
reg [31:0] new_addr;
wire [31:0] current_pc;

pc pc(
    .clk(clk),
    .reset(reset),
    .pcwre(pcwre),
    .new_addr(new_addr),
    .current_pc(current_pc)
    );
    
    initial begin
    clk=1;
    reset=0;
    
    #40 
    clk=0;
     reset=1;
    
    forever #20 clk=!clk;
    #600 $stop;
    end
endmodule
