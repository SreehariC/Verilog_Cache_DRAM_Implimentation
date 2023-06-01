`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2023 22:36:18
// Design Name: 
// Module Name: top
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


module top(
input clk,input [31:0] ins,input en,output [12:0] hit_counter,output [20:0] counter,output [12:0] miss_counter
    );
    
    wire grant_line; 
    wire iamtaking;
    wire [31:0] mem;
    wire [31:0] data_out;
//    wire [31:0] data_out1;
    wire iamsending;
    wire recieved;
    wire done;
    wire pop;
    Memory_controller me(clk,done,iamsending,recieved,iamtaking,grant_line,pop);
    processor p(clk,en,iamtaking,ins,mem,data_out,iamsending,recieved);
    Memory M(clk,data_out,grant_line,mem,done,hit_counter,counter,pop,miss_counter);
endmodule