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
    output [1:0]regdst,
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
    output [31:0]alu_inputb,
    
    output [2:0]state,
    
    output irwre,
    output [31:0]bincode, 
    output [31:0]adr_out,
    output [31:0]bdr_out,
    output [31:0]aluoutdr_out,
    output [31:0]databus_before,
    output [31:0]databus,
    output wrregdsrc
    
//    output [31:0]cur_pc_4
    );
//    wire [4:0] write_reg;
//    wire [31:0]dataout;
//    wire [31:0]ext_immediate;
//    wire pcwre;
//    wire regwre;
//    wire extsel;
//    wire dbdatasrc;
//    wire [1:0]regdst;
//    wire alusrca;
//    wire alusrcb;
//    wire mrd;
//    wire mwr;
//    wire [2:0]aluop;
//    wire [1:0]pcsrc;
//    wire zero;
//    wire sign;
//    wire [31:0]alu_inputa;
//    wire [31:0]alu_inputb;
    wire [31:0]cur_pc_4=cur_pc+4;
    
    
//    wire irwre;
//    wire [31:0]bincode; 
//    wire [31:0]adr_out;
//    wire [31:0]bdr_out;
//    wire [31:0]aluoutdr_out;
//    wire [31:0]databus_before;
//    wire [31:0]databus;
//    wire wrregdsrc;
    wire [5:0]opcode=bincode[31:26];
    wire [5:0]funct=bincode[5:0];
    wire [4:0]rs=bincode[25:21];
    wire [4:0]rt=bincode[20:16];
    wire [4:0]rd=bincode[15:11]; 
    
    mux4_32bits mux_nextiaddr(.choice(pcsrc),.in0(cur_pc+4),.in1(cur_pc+4+(ext_immediate<<2)),.in2(data_rs),.in3({cur_pc[31:28],bincode[25:0],2'b00}),.out(new_pcaddr));
    
//    assign new_pcaddr=(pcsrc==2'b01)?cur_pc_4+(ext_immediate<<2):(pcsrc==2'b10)?({cur_pc_4[31:28],bincode[25:0],2'b00}):cur_pc_4;
    pc pc(.reset(reset),.pcwre(pcwre),.clk(clk),.new_addr(new_pcaddr),.current_pc(cur_pc));
    instruction_mem ins_m(.iaddr(cur_pc),.idataout(instruction));
    alu alu(alu_inputa,alu_inputb,aluop,alu_res,zero,sign);
    datamem data_m(clk,aluoutdr_out,bdr_out,mrd,mwr,dataout);
    extension extension(extsel,bincode[15:0],ext_immediate);
    //mux_5b rtorrd_mux_5b(regdst,instruction[20:16],instruction[15:11],write_reg);
      mux_32b alua_mux_32b(alusrca,{27'b000000000000000000000000000,bincode[10:6]},adr_out,alu_inputa);
      mux4_5bits mux_writereg(.choice(regdst),.in0(5'd31),.in1(rt),.in2(rd),.in3(5'bzzzzz),.out(write_reg));
      mux_32b alub_mux_32b(alusrcb,ext_immediate,bdr_out,alu_inputb);
      mux_32b alures_mux_32b(dbdatasrc,dataout,alu_res,databus_before);
      mux_32b mux_writedata(wrregdsrc,databus,cur_pc_4,write_data);
      register_file res_file(rs,rt,write_reg,regwre,clk,write_data,reset,data_rs,data_rt);
      //control_unit con_unit(zero,sign,instruction[31:26],instruction[5:0],pcwre,regwre,extsel,insmemrw,dbdatasrc,regdst,alusrca,alusrcb,pcsrc,mrd,mwr,aluop);
    ir ir(.clk(clk),.irwre(irwre),.insin(instruction),.insout(bincode));
    dff_32bits adr(.clk(clk),.reset(reset),.in(data_rs),.out(adr_out));
    dff_32bits bdr(.clk(clk),.reset(reset),.in(data_rt),.out(bdr_out));
    dff_32bits aluoutdr(.clk(clk),.reset(reset),.in(alu_res),.out(aluoutdr_out));
    dff_32bits dbdr(.clk(clk),.reset(reset),.in(databus_before),.out(databus));
    control_unit con_unit(.clk(clk),.funct(funct),.rst(reset),.zero(zero),.sign(sign),.opcode(opcode),.pcwre(pcwre),.alusrca(alusrca),.alusrcb(alusrcb),.dbdatasrc(dbdatasrc),.regwre(regwre),.wrregdsrc(wrregdsrc),.insmemrw(insmemrw),.mrd(mrd),.mwr(mwr),.irwre(irwre),.extsel(extsel),.pcsrc(pcsrc),.regdst(regdst),.aluop(aluop),.state(state));
    
endmodule
