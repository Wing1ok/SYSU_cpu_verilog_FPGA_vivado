`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/19 10:35:16
// Design Name: 
// Module Name: basys3
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


module basys3(
input button,
input [1:0]sw,
input CLK,
input reset,
output [7:0]digit_out,
output reg[3:0]an
    );
    
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
    wire clk;
    
    parameter T1MS=500;
    reg[19:0]count;
    reg[3:0]value;
    
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
    initial begin
    count<=0;
    an<=4'b0111;
    end
    debounce debounce(CLK,button,clk);
    always@(posedge CLK)
    begin
    if(reset==0)begin
    count<=0;
    an<=4'b0000;
    end
    else begin
    count=count+1;
    if(count==T1MS)begin
    count<=0;
    case(an)
    4'b1110:an=4'b1101;
    4'b1101:an=4'b1011;
    4'b1011:an=4'b0111;
    4'b0111:an=4'b1110;
    4'b0000:an=4'b0111;
    endcase
    end
    end
    end
    seg_led led(reset,value,digit_out);
    always@(posedge CLK)
    begin
    case(an)
    4'b1110:
    begin
    case(sw)
    2'b00:value=new_pcaddr[3:0];
    2'b01:value=data_rs[3:0];
    2'b10:value=data_rt[3:0];
    2'b11:value=dataout[3:0];
    endcase
    end
    4'b1101:
    begin
    case(sw)
    2'b00:value=new_pcaddr[7:4];
    2'b01:value=data_rs[7:4];
    2'b10:value=data_rt[7:4];
    2'b11:value=dataout[7:4];
    endcase
    end
    4'b1011:
    begin
    case(sw)
    2'b00:value=cur_pc[3:0];
    2'b01:value=instruction[24:21];
    2'b10:value=instruction[19:16];
    2'b11:value=alu_res[3:0];
    endcase
    end
    4'b0111:
    begin
    case(sw)
    2'b00:value=cur_pc[7:4];
    2'b01:value={3'b000,instruction[25]};
    2'b10:value={3'b000,instruction[20]};
    2'b11:value=alu_res[7:4];
    endcase
    end
    endcase
    end
endmodule
