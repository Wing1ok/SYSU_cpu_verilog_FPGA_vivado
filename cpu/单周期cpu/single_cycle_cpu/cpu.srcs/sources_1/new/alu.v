`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/12 22:22:35
// Design Name: 
// Module Name: alu
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


module alu(
input [31:0] a,b,
input[2:0] aluop,
output reg[31:0] result,
output zero,sign
    );
    
    always@(*)
    begin
    case(aluop)
    3'b000:result=a+b;
    3'b001:result=a-b;
    3'b010:result=b<<a;
    3'b011:result=a|b;
    3'b100:result=a&b;
    3'b101:result=a<b?1:0;
    3'b110:result=((a<b&&a[31]==b[31])||(a[31]==1&&b[31]==0)?1:0);
    3'b111:result=a^b;
    default:result=0;
    endcase
    end
    assign zero = result==0;
    assign sign = result[31]==1;
endmodule
