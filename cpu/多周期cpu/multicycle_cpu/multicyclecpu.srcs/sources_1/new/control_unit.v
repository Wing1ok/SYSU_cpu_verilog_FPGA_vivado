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
input clk,rst,
input zero,sign,
input [5:0]opcode,
input [5:0]funct,
output wire insmemrw,
output reg pcwre,alusrca,alusrcb,dbdatasrc,regwre,wrregdsrc,mrd,mwr,irwre,extsel,
output reg [1:0]pcsrc,
output reg [1:0]regdst,
output reg [2:0]aluop,
output reg [2:0]state
    );
    
//    reg [2:0] state;
    assign insmemrw=1;
    
    parameter if_state=3'b000;
    parameter id_state=3'b001;
    parameter exe1_state=3'b110;
    parameter exe2_state=3'b101;
    parameter exe3_state=3'b010;
    parameter mem_state=3'b011;
    parameter wb1_state=3'b111;
    parameter wb3_state=3'b100;
    
    always @(posedge clk or negedge rst)begin
    if(rst==0)begin
    state<=if_state;
    pcwre<=1;
    irwre<=0;
    end
    else begin
    case(state)
    3'b000:state<=3'b001;
    3'b001:begin
    if(opcode==6'b000100||opcode==6'b000101||opcode==6'b000001)state<=3'b101;
    else if(opcode==6'b101011||opcode==6'b100011)state<=3'b010;
    else if(opcode==6'b000010||(opcode==6'b000000&&funct==6'b001000)||opcode==6'b000011||opcode==6'b111111)state<=3'b000;
    else state<=3'b110;
    end
    3'b110:state<=3'b111;
    3'b010:state<=3'b011;
    3'b011:begin
    if(opcode==6'b100011)state<=3'b100;
    else state<=3'b000;
    end
    3'b111,3'b101,3'b100:state<=3'b000;
    endcase
    end
    end
    
    always @(state or opcode or zero or sign)begin
    case(opcode)
    6'b000000:begin
    case(funct)
    6'b100000:begin
    {alusrca,alusrcb,dbdatasrc,wrregdsrc,mrd,extsel,pcsrc[1:0],regdst[1:0],aluop[2:0]}<=13'b000100_00_10_000;
    case(state)
    3'b000:{irwre,mwr,regwre}=3'b000;
    3'b001:{irwre,mwr,regwre}=3'b000;
    3'b110:{irwre,mwr,regwre}=3'b000;
    3'b111:{irwre,mwr,regwre}=3'b001;
    endcase
    end
    6'b100010:begin
    {alusrca,alusrcb,dbdatasrc,wrregdsrc,mrd,extsel,pcsrc[1:0],regdst[1:0],aluop[2:0]}<=13'b000100_00_10_001;
    case(state)
    3'b000:{irwre,mwr,regwre}=3'b000;
    3'b001:{irwre,mwr,regwre}=3'b000;
    3'b110:{irwre,mwr,regwre}=3'b000;
    3'b111:{irwre,mwr,regwre}=3'b001;
    endcase
    end
    6'b100100:begin
    {alusrca,alusrcb,dbdatasrc,wrregdsrc,mrd,extsel,pcsrc[1:0],regdst[1:0],aluop[2:0]}<=13'b000100_00_10_100;
    case(state)
    3'b000:{irwre,mwr,regwre}=3'b000;
    3'b001:{irwre,mwr,regwre}=3'b000;
    3'b110:{irwre,mwr,regwre}=3'b000;
    3'b111:{irwre,mwr,regwre}=3'b001;
    endcase
    end
    6'b000000:begin
    {alusrca,alusrcb,dbdatasrc,wrregdsrc,mrd,extsel,pcsrc[1:0],regdst[1:0],aluop[2:0]}<=13'b100100_00_10_010;
    case(state)
    3'b000:{irwre,mwr,regwre}=3'b000;
    3'b001:{irwre,mwr,regwre}=3'b000;
    3'b110:{irwre,mwr,regwre}=3'b000;
    3'b111:{irwre,mwr,regwre}=3'b001;
    endcase
    end
    6'b101010:begin
    {alusrca,alusrcb,dbdatasrc,wrregdsrc,mrd,extsel,pcsrc[1:0],regdst[1:0],aluop[2:0]}<=13'b000100_00_10_110;
    case(state)
    3'b000:{irwre,mwr,regwre}=3'b000;
    3'b001:{irwre,mwr,regwre}=3'b000;
    3'b110:{irwre,mwr,regwre}=3'b000;
    3'b111:{irwre,mwr,regwre}=3'b001;
    endcase
    end
    6'b001000:begin
    {alusrca,alusrcb,dbdatasrc,wrregdsrc,mrd,extsel,pcsrc[1:0],regdst[1:0],aluop[2:0]}<=13'b000100_10_00_000;
    case(state)
    3'b000:{irwre,mwr,regwre}=3'b000;
    3'b001:{irwre,mwr,regwre}=3'b000;
    endcase
    end
    endcase
    end
    6'b001001:begin
    {alusrca,alusrcb,dbdatasrc,wrregdsrc,mrd,extsel,pcsrc[1:0],regdst[1:0],aluop[2:0]}<=13'b010101_00_01_000;
    case(state)
    3'b000:{irwre,mwr,regwre}=3'b000;
    3'b001:{irwre,mwr,regwre}=3'b000;
    3'b110:{irwre,mwr,regwre}=3'b000;
    3'b111:{irwre,mwr,regwre}=3'b001;
    endcase
    end
    6'b001100:begin
    {alusrca,alusrcb,dbdatasrc,wrregdsrc,mrd,extsel,pcsrc[1:0],regdst[1:0],aluop[2:0]}<=13'b010100_00_01_100;
    case(state)
    3'b000:{irwre,mwr,regwre}=3'b000;
    3'b001:{irwre,mwr,regwre}=3'b000;
    3'b110:{irwre,mwr,regwre}=3'b000;
    3'b111:{irwre,mwr,regwre}=3'b001;
    endcase
    end
    6'b001101:begin
    {alusrca,alusrcb,dbdatasrc,wrregdsrc,mrd,extsel,pcsrc[1:0],regdst[1:0],aluop[2:0]}<=13'b010100_00_01_011;
    case(state)
    3'b000:{irwre,mwr,regwre}=3'b000;
    3'b001:{irwre,mwr,regwre}=3'b000;
    3'b110:{irwre,mwr,regwre}=3'b000;
    3'b111:{irwre,mwr,regwre}=3'b001;
    endcase
    end
    6'b001110:begin
    {alusrca,alusrcb,dbdatasrc,wrregdsrc,mrd,extsel,pcsrc[1:0],regdst[1:0],aluop[2:0]}<=13'b010100_00_01_111;
    case(state)
    3'b000:{irwre,mwr,regwre}=3'b000;
    3'b001:{irwre,mwr,regwre}=3'b000;
    3'b110:{irwre,mwr,regwre}=3'b000;
    3'b111:{irwre,mwr,regwre}=3'b001;
    endcase
    end
    6'b001010:begin
    {alusrca,alusrcb,dbdatasrc,wrregdsrc,mrd,extsel,pcsrc[1:0],regdst[1:0],aluop[2:0]}<=13'b010101_00_01_110;
    case(state)
    3'b000:{irwre,mwr,regwre}=3'b000;
    3'b001:{irwre,mwr,regwre}=3'b000;
    3'b110:{irwre,mwr,regwre}=3'b000;
    3'b111:{irwre,mwr,regwre}=3'b001;
    endcase
    end
    6'b101011:begin
    {alusrca,alusrcb,dbdatasrc,wrregdsrc,mrd,extsel,pcsrc[1:0],regdst[1:0],aluop[2:0]}<=13'b010101_00_00_000;
    case(state)
    3'b000:{irwre,mwr,regwre}=3'b000;
    3'b001:{irwre,mwr,regwre}=3'b000;
    3'b010:{irwre,mwr,regwre}=3'b000;
    3'b011:{irwre,mwr,regwre}=3'b010;
    endcase
    end
    6'b100011:begin
    {alusrca,alusrcb,dbdatasrc,wrregdsrc,mrd,extsel,pcsrc[1:0],regdst[1:0],aluop[2:0]}<=13'b011111_00_01_000;
    case(state)
    3'b000:{irwre,mwr,regwre}=3'b000;
    3'b001:{irwre,mwr,regwre}=3'b000;
    exe3_state:{irwre,mwr,regwre}=3'b000;
    mem_state:{irwre,mwr,regwre}=3'b000;
    wb3_state:{irwre,mwr,regwre}=3'b001;
    endcase
    end
    6'b000100:begin
    {alusrca,alusrcb,dbdatasrc,wrregdsrc,mrd,extsel,regdst[1:0],aluop[2:0]}<=11'b000101_00_001;
    pcsrc[1:0]<=(zero==1)?2'b01:2'b00;
    case(state)
    3'b000:{irwre,mwr,regwre}=3'b000;
    default:{irwre,mwr,regwre}=3'b000;
    endcase
    end
    6'b000101:begin
    {alusrca,alusrcb,dbdatasrc,wrregdsrc,mrd,extsel,pcsrc[1:0],regdst[1:0],aluop[2:0]}<=11'b000101_00_001;
    pcsrc[1:0]<=(zero==0)?2'b01:2'b00;
    case(state)
    3'b000:{irwre,mwr,regwre}=3'b000;
    default:{irwre,mwr,regwre}=3'b000;
    endcase
    end
    6'b000001:begin
    {alusrca,alusrcb,dbdatasrc,wrregdsrc,mrd,extsel,regdst[1:0],aluop[2:0]}<=11'b000101_00_000;
    pcsrc[1:0]<=(sign==1)? 2'b01:2'b00;
    case(state)
    3'b000:{irwre,mwr,regwre}=3'b000;
    default:{irwre,mwr,regwre}=3'b000;
    endcase
    end
    6'b000010:begin
    {alusrca,alusrcb,dbdatasrc,wrregdsrc,mrd,extsel,pcsrc[1:0],regdst[1:0],aluop[2:0]}<=13'b000100_11_00_000;
    case(state)
    3'b000:{irwre,mwr,regwre}=3'b000;
    3'b001:{irwre,mwr,regwre}=3'b000;
    endcase
    end
    6'b000011:begin
    {alusrca,alusrcb,dbdatasrc,wrregdsrc,mrd,extsel,pcsrc[1:0],regdst[1:0],aluop[2:0]}<=13'b000000_11_00_000;
    case(state)
    3'b000:{irwre,mwr,regwre}=3'b000;
    3'b001:{irwre,mwr,regwre}=3'b001;
    endcase
    end
    6'b111111:begin
    {alusrca,alusrcb,dbdatasrc,wrregdsrc,mrd,extsel,pcsrc[1:0],regdst[1:0],aluop[2:0]}<=13'b000100_00_00_000;
    {irwre,mwr,regwre}=4'b000;
    end
    endcase
    end
    always @(negedge clk) begin
    case(state)
    3'b111,3'b101,3'b100:pcwre<=1;
    3'b011:pcwre<=(opcode == 6'b101011 ? 1:0);
    3'b001:pcwre<=(opcode==6'b000010||(opcode==6'b000000&&funct==6'b001000)||opcode==6'b000011 ? 1:0);
    default:pcwre<=0;
    endcase
    end
endmodule
