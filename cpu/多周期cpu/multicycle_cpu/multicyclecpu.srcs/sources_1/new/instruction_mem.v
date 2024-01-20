`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/12 20:13:36
// Design Name: 
// Module Name: instruction_mem
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


module instruction_mem(
input [31:0] iaddr,
output reg [31:0] idataout

    );
    
reg [7:0] mem[255:0];
initial
begin
$readmemb("C:/Users/12434/Desktop/instructions_multiple.txt",mem);
end
always@(iaddr )
begin
idataout={mem[iaddr],mem[iaddr+1],mem[iaddr+2],mem[iaddr+3]};
end
endmodule
