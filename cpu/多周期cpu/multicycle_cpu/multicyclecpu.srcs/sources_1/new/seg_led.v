`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/19 11:18:37
// Design Name: 
// Module Name: seg_led
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


module seg_led(
input reset,
input [3:0]digit_in,
output reg[7:0]out
    );
    
    always@(digit_in or reset)
    begin
    if(reset==0) out=8'b11111110;
    else begin
    case(digit_in)
                     4'b0000:	 out=	 8'b00000011;	 //0
                     4'b0001:    out=    8'b10011111;    //1
                     4'b0010:    out=    8'b00100101;    //2
                     4'b0011:    out=    8'b00001101;    //3
                     4'b0100:    out=    8'b10011001;    //4
                     4'b0101:    out=    8'b01001001;    //5
                     4'b0110:    out=    8'b01000001;    //6
                     4'b0111:    out=    8'b00011111;    //7
                     4'b1000:    out=    8'b00000001;    //8
                     4'b1001:    out=    8'b00001001;    //9
                     4'b1010:    out=    8'b00010001;    //A
                     4'b1011:    out=    8'b11000001;    //B
                     4'b1100:    out=    8'b01100011;    //C
                     4'b1101:    out=    8'b10000101;    //D
                     4'b1110:    out=    8'b01100001;    //E
                     4'b1111:    out=    8'b01110001;    //F
                     default:    out=    8'b00000000;   
                     endcase
                     end
                     end
endmodule
