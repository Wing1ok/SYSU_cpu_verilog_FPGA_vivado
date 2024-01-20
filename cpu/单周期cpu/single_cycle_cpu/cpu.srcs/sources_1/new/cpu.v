`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/12 19:44:45
// Design Name: 
// Module Name: cpu
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


module cpu(
    input clk,
    input reset,
    output [31:0]cur_pc,
    output [31:0]new_pcaddr,
    output [31:0]instruction,
    output [31:0]data_rs,
    output [31:0]data_rt,
    output [31:0]alu_res,
    output [31:0]write_data,
    output [31:0]ext_immediate,
    output pcwre,
    output regwre,
    output extsel,
    output dbdatasrc,
    output regdst,
    output alusrca,
    output alusrcb,
    output mrd,
    output mwr,
    output [2:0]aluop,
    output [31:0]dataout,
    output [4:0] write_reg,
    output [1:0]pcsrc,
    output zero,
    output sign,
    output [31:0]alu_inputa,
    output [31:0]alu_inputb
//    output [31:0]cur_pc_4
    );
    wire [4:0] write_reg;
    wire [31:0]dataout;
    wire [31:0]ext_immediate;
    wire pcwre;
    wire regwre;
    wire extsel;
    wire dbdatasrc;
    wire regdst;
    wire alusrca;
    wire alusrcb;
    wire mrd;
    wire mwr;
    wire [2:0]aluop;
    wire [1:0]pcsrc;
    wire zero;
    wire sign;
    wire [31:0]alu_inputa;
    wire [31:0]alu_inputb;
    wire [31:0]cur_pc_4=cur_pc+4;
    
    assign new_pcaddr=(pcsrc==2'b01)?cur_pc_4+(ext_immediate<<2):(pcsrc==2'b01)?({cur_pc_4[31:28],instruction[25:0],2'b00}):cur_pc_4;
    pc pc(.reset(reset),.pcwre(pcwre),.clk(clk),.new_addr(new_pcaddr),.current_pc(cur_pc));
    instruction_mem ins_m(.iaddr(cur_pc),.idataout(instruction));
    alu alu(alu_inputa,alu_inputb,aluop,alu_res,zero,sign);
    datamem data_m(clk,alu_res,data_rt,mrd,mwr,dataout);
    extension extension(extsel,instruction[15:0],ext_immediate);
    mux_5b rtorrd_mux_5b(regdst,instruction[20:16],instruction[15:11],write_reg);
          mux_32b alua_mux_32b(alusrca,{27'b000000000000000000000000000,instruction[10:6]},data_rs,alu_inputa);
      mux_32b alub_mux_32b(alusrcb,ext_immediate,data_rt,alu_inputb);
      mux_32b alures_mux_32b(dbdatasrc,dataout,alu_res,write_data);
      register_file res_file(instruction[25:21],instruction[20:16],write_reg,regwre,clk,write_data,data_rs,data_rt);
      control_unit con_unit(zero,sign,instruction[31:26],instruction[5:0],pcwre,regwre,extsel,insmemrw,dbdatasrc,regdst,alusrca,alusrcb,pcsrc,mrd,mwr,aluop);

endmodule
