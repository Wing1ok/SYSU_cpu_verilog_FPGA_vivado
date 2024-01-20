`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/14 19:28:24
// Design Name: 
// Module Name: sim_basys3
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


module sim_basys3(

    );
    
    reg button;
    reg [1:0]sw;
    reg CLK;
    reg reset;
    wire [7:0]digit_out;
    wire [3:0]an;
    
    basys3 basys3(button,sw,CLK,reset,digit_out,an);
    
    initial begin
    CLK=1;
     reset=0;
     sw=1;
     button=1;
    #20 reset=1;
    end
    always #5  CLK=!CLK; 
    always #50000 button=!button;
endmodule
