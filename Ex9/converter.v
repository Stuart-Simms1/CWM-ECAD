//////////////////////////////////////////////////////////////////////////////////
// Exercise #6 - RGB Colour Converter
// Student Name:
// Date: 
//
//
//  Description: In this exercise, you need to design a memory with 8 entries, 
//  converting colours to their RGB code.
//
//  inputs:
//           clk, colour [2:0], enable
//
//  outputs:
//           rgb [23:0]
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps
module converter(
	input clk,
	input [2:0] colour,
	input enable,
	output [23:0] rgb
	);

	
	blk_mem_gen_2  your_instance_name (
  		.clka(clk),      // input wire clka
  		.ena(enable),    // input wire ena
  		.wea(1'b0),      // input wire [0 : 0] wea
  		.addra(colour),  // input wire [2 : 0] addra
 		.dina(24'b0),    // input wire [23 : 0] dina
 		.douta(rgb)      // output wire [23 : 0] douta
	);
endmodule
