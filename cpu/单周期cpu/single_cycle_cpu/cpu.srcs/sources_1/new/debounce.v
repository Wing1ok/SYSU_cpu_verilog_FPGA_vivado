`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/19 11:05:27
// Design Name: 
// Module Name: debounce
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


module debounce(
input CLK,
input in_key,
output KEY
    );
    
    parameter T1MS=5000;
    reg[21:0]count_low;
    reg[21:0]count_high;
    reg out_key;
    always@(posedge CLK)
    begin
    if(in_key==1'b0)
    count_low=count_low+1;
    else
    count_low=1'b0;
    end
    
    always@(posedge CLK)
    begin
    if(in_key==1'b1)
    count_high=count_high+1;
    else
    count_high=1'b0;
    end
    always@(posedge CLK)
    begin
    if(count_low==T1MS)
    out_key=1'b0;
    else if(count_high==T1MS)
    out_key=1'b1;
    end
    assign KEY=!out_key;
endmodule
