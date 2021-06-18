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
	reg out; 	//Since the output has to maintain its value it must be a reg

    //Todo: define your logic here
	always @ (*) begin		//do the assignment on any event * occuring
		#5;		//Required 5 tick delay between input change and output change
		if (sel)
			out = b;	//Sets output to B if sel is 1
		else
			out = a;	//Sets output to A if sel is 0
	end
      
endmodule
