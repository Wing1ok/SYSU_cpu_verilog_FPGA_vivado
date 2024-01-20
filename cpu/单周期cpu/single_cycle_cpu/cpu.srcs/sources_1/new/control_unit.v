`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/12 22:31:00
// Design Name: 
// Module Name: control_unit
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


module control_unit(
input zero,sign,
input [5:0]op,
input [5:0]func,
output pcwre,
output regwre,
output extsel,
output insmemwr,
output dbdatasrc,
output regdst,
output alusrca,
output alusrcb,
output [1:0] pcsrc,
output mrd,
output mwr,
output [2:0] aluop
    );
    parameter halt = 6'b111111;
    parameter addiu = 6'b001001;
    parameter ori = 6'b001101;
    parameter bne =6'b000101;
    parameter slti = 6'b001010;
    parameter beq = 6'b110000;
    parameter sw = 6'b101011;
    parameter lw = 6'b100011;
    parameter bltz = 6'b000001;
    parameter j = 6'b000010;
    parameter andi = 6'b001000;
    parameter add_func = 6'b100000;
    parameter sub_func = 6'b100010; 
    parameter and_func = 6'b100100;
    parameter or_func=  6'b100101;
    parameter sll_func = 6'b000000;
    parameter add_ = 3'b000;
    parameter sub_ = 3'b001;
    parameter sll_ = 3'b010;
    parameter or_ =  3'b011;
    parameter and_ = 3'b100;
    parameter slti_ = 3'b110;
    
    wire regwre_func;
    wire aluop_sub;
    wire aluop_add;
    wire aluop_and;
    wire aluop_or;
    
    assign regwre_func =func==add_func||func==sub_func||func==or_func||func==and_func||func==sll_func;
    assign aluop_sub=func==sub_func||op==bne||op==beq||op==bltz;
    assign aluop_add= func==add_func||op==addiu;
        assign aluop_and = func==and_func||op==andi;
    assign aluop_or = func==or_func||op==ori;
    assign pcwre = op!=halt;
    assign alusrca = func==sll_func;
    assign alusrcb = op==addiu||op==andi||op==ori||op==slti||op==sw||op==lw;
    assign dbdatasrc = op==lw;
    assign regwre = regwre_func||op==addiu||op==ori||op==andi||op==slti||op==lw;
    assign insmemrw = 1;
    assign mrd = op==lw;
    assign mwr = op==sw;
    assign regdst = func==add_func||func==or_func||func==sub_func||func==sll_func||func==and_func;
    assign extsel = op!=andi&&op!=ori;  //op==slti||op==sw||op==lw||op==beq||op==bne||op==bltz||op==addiu;
    assign pcsrc[0] = (op==beq&&zero==1)||(op==bne&&zero==0)||(op==bltz&&sign==1);
    assign pcsrc[1] = op==j; 
    assign aluop = aluop_add?add_:aluop_sub?sub_:aluop_or?or_:func==sll_func?sll_:op==slti?slti_:aluop_and?and_:111;

endmodule
