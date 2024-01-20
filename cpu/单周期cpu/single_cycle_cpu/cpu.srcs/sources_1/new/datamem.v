`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/12 22:03:11
// Design Name: 
// Module Name: datamem
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

`timescale 1ns/1ps

module datamem(
input clk,
input [31:0]Daddr,
input [31:0]datain,
input mRD,mWR,
output reg [31:0]dataout
    );
    reg [7:0]mem[255:0];
    integer i;
    initial begin
    for(i=0;i<256;i=i+1)
    mem[i]<=0;
    end
    always@(Daddr or mRD)
    begin
    if(mRD==1)
    begin
    dataout[31:24]=mem[Daddr];
    dataout[23:16]=mem[Daddr+1];
    dataout[15:8]=mem[Daddr+2];
    dataout[7:0]=mem[Daddr+3];
    end
    end
    always@(negedge clk)
    begin
    if(mWR==1)
    begin
    mem[Daddr]<=datain[31:24];
    mem[Daddr+1]<=datain[23:16];
    mem[Daddr+2]<=datain[15:8];
    mem[Daddr+3]<=datain[7:0];
    end
    end
endmodule
