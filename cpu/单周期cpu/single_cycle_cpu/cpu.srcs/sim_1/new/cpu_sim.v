`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/16 10:59:20
// Design Name: 
// Module Name: cpu_sim
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


module cpu_sim(

    );
    reg clk;
    reg reset;
    wire [31:0]cur_pc;
    wire [31:0]new_pcaddr;
    wire [31:0]instruction;
    wire [31:0]data_rs;
    wire [31:0]data_rt;
    wire [31:0]alu_res;
    wire [31:0]write_data;
    wire [31:0]ext_immediate;
    wire pcwre;
    wire regwre;
    wire extsel;
    wire dbdatasrc;
    wire [1:0]regdst;
    wire alusrca;
    wire alusrcb;
    wire mrd;
    wire mwr;
    wire [2:0]aluop;
    wire [31:0]dataout;
    wire [4:0] write_reg;
    wire [1:0]pcsrc;
    wire zero;
    wire sign;
    wire [31:0]alu_inputa;
    wire [31:0]alu_inputb;
    
    wire [2:0]state;

    wire irwre;
    wire [31:0]bincode; 
    wire [31:0]adr_out;
    wire [31:0]bdr_out;
    wire [31:0]aluoutdr_out;
    wire [31:0]databus_before;
    wire [31:0]databus;
    wire wrregdsrc;

    wire [5:0]opcode=bincode[31:26];
    wire [5:0]funct=bincode[5:0];
    wire [4:0]rs=bincode[25:21];
    wire [4:0]rt=bincode[20:16];
    wire [4:0]rd=bincode[15:11]; 
//    wire [31:0]cur_pc_4;
    cpu s(
    .clk(clk),
    .reset(reset),
    .cur_pc(cur_pc),
    .new_pcaddr(new_pcaddr),
    .alu_res(alu_res),
     .write_data(write_data),
    .data_rs(data_rs),
    .data_rt(data_rt),
     .instruction(instruction),
    .ext_immediate(ext_immediate),
    .pcwre(pcwre),
    .regwre(regwre),
    .extsel(extsel),
    .dbdatasrc(dbdatasrc),
    .regdst(regdst),
    .alusrca(alusrca),
    .alusrcb(alusrcb),
    .mrd(mrd),
    .mwr(mwr),
    .aluop(aluop),
    .dataout(dataout),
    .write_reg(write_reg),
    .pcsrc(pcsrc),
    .zero(zero),
    .sign(sign),
    .alu_inputa(alu_inputa),
    .alu_inputb(alu_inputb),
    
    .irwre(irwre),
    .bincode(bincode), 
    .adr_out(adr_out),
    .bdr_out(bdr_out),
    .aluoutdr_out(aluoutdr_out),
    .databus_before(databus_before),
    .databus(databus),
    .wrregdsrc(wrregdsrc),
//    .cur_pc_4(cur_pc_4)
    
    .state(state)
    
    );
    
   mux4_32bits mux_nextiaddr(.choice(pcsrc),.in0(cur_pc+4),.in1(cur_pc+4+(ext_immediate<<2)),.in2(data_rs),.in3({cur_pc[31:28],bincode[25:0],2'b00}),.out(new_pcaddr));

    
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
    
    initial begin
    clk=1;
     reset=0;
    #5 clk=!clk;
    reset=1;
    forever #5 begin clk=!clk; end
    end
endmodule
