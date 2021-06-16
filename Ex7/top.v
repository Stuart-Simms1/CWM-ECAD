//////////////////////////////////////////////////////////////////////////////////
// Exercise #7 - Lights Selector
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to implement a selector between RGB 
// lights and a white light, coded in RGB. If sel is 0, white light is used. If
//  the sel=1, the coded RGB colour is the output.
//
//  inputs:
//           clk, sel, rst, button
//
//  outputs:
//           light [23:0]
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

//wasn't sure if the code for the other modules needed to be just in files around here or if they have to be coded in top.v
module selector (
	input clk,
	input sel,
	input rst,
	input button,
	output reg [23:0]light);
	//regs and wires
	wire colour;
	
	always @ (posedge clk) begin
		colours colours(.clk (clk), .rst (rst), .button (button), .colour (colour));
		if(~sel) begin
			light[23:0] <= 24'hFFFFFF;
		end
		else begin 
			converter Converter(.clk (clk), .colour (colour), .enable (1), .rgb (light));
		end
	end
	
endmodule
