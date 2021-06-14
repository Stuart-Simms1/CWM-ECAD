//////////////////////////////////////////////////////////////////////////////////
// Exercise #2 - Doorbell Chime
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to design a multiplexer that chooses between two sounds, where the  
//  output is delayed by 5 ticks (not clocks!) and acts according to the following truth table:
//
//  sel | out
// -----------------
//   0  | a
//   1  | b
//
//  inputs:
//           a, b, sel
//
//  outputs:
//           out
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module doorbell(
    //Todo: define inputs here
	input a,
	input b,
	input sel,
	output out
    );
    
    //Todo: define registers and wires here
	reg out;

    //Todo: define your logic here
	always @ (*) begin
	#5;
	if (sel)
	out = b;
	else
	out = a;
	end
      
endmodule
