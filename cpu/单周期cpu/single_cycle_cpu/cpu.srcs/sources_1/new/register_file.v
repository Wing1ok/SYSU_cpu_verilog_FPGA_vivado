`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/12 20:32:03
// Design Name: 
// Module Name: register_file
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


module register_file(
input [4:0] rs,
input [4:0] rt,
input [4:0] write_reg,
input we,clk,
input [31:0] write_data,
output [31:0] read_data1,
output [31:0] read_data2
    );
    reg [31:0] registers[0:31];
    integer i;
    initial begin
    for(i=0;i<=31;i=i+1) registers[i]<=0;
    end
    assign read_data1= rs?registers[rs]:0;
    assign read_data2= rt?registers[rt]:0;
    
    always@(posedge clk)
    begin
        if(we&&write_reg)begin
        registers[write_reg]=write_data;
        end
    end
endmodule
