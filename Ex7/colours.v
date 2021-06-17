//////////////////////////////////////////////////////////////////////////////////
// Exercise #4 - Dynamic LED lights
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to design a LED based lighting solution, 
//  following the diagram provided in the exercises documentation. The lights change 
//  as long as a button is pressed, and stay the same when it is released. 
//
//  inputs:
//           clk, rst, button
//
//  outputs:
//           colour [2:0]
//
//  You need to write the whole file.
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps
module colours(
	input clk,
	input rst,
	input button,
	output reg [2:0]colour);
	
	
	initial begin	//to define colour from the beginning (not necessary as we reset it in the simulation immediately)
	colour = 3'b000;
	end
	
	always @(posedge clk) begin
		if(rst) begin		//resetting takes precedence
			colour <= 3'b111;
		end
		else begin	
			if(button) begin
				case(colour)
				    3'b111 : colour <= 3'b001;
				    3'b000 : colour <= 3'b001;
				    3'b110 : colour <= 3'b001 ;					//110 + 1 would take us out of scope so set it to 001
				    default : colour <= colour + 3'b1;			//works for all the other colours
				endcase

			end
			else begin
				case(colour)
				3'b111: colour <= 3'b001;
				3'b000: colour <= 3'b001;
				default : ;
				endcase
			end
		end
	end
	
endmodule
