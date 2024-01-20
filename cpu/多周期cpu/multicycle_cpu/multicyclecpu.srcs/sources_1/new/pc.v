`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/12 19:47:56
// Design Name: 
// Module Name: pc
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


module pc(
input clk,
input reset,
input pcwre,
input [31:0] new_addr,
output reg [31:0] current_pc
    );
    initial begin
     current_pc = 0;
    end
    always@( posedge clk or negedge reset)
    begin
    if(reset==0) current_pc=0;
    
    else
        if(pcwre==1)
        begin
            current_pc=new_addr;
        end
    end
endmodule
