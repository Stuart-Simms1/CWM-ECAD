//////////////////////////////////////////////////////////////////////////////////
// Exercise #5 - Air Conditioning
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to an air conditioning control system
//  According to the state diagram provided in the exercise.
//
//  inputs:
//           clk, temperature [4:0]
//
//  outputs:
//           heating, cooling
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps
module heater (
	input clk,
	input [4:0] temperature,
	output reg heating,
	output reg cooling);
	
	//function of the module
	always @ (posedge clk) begin
		if((heating ==1) && (cooling == 0)) begin
			if(temperature < 5'b10100) begin
				heating = 1;
				cooling = 0;
			end
			if(temperature >= 5'b10100) begin
				heating = 0;
				cooling = 0;
			end
		end
		else begin
			if((heating == 0) && (cooling == 0)) begin
				if(temperature <= 5'b10010) begin
					heating = 1;
					cooling = 0;
				end
				if((temperature > 5'b10010) && (temperature < 5'b10110)) begin
					heating = 0;
					cooling = 0;
				end
				if(temperature >= 5'b10110) begin
					heating = 0;
					cooling = 1;
				end
			end
			else begin 
				if((heating == 0) && (cooling == 1)) begin
					if(temperature <= 5'b10100) begin
						heating = 0;
						cooling = 0;
					end
					if(temperature > 5'b10100) begin
						heating = 0;
						cooling = 1;
					end
				end
				else begin
					$display("heating and cooling undefined, going idle");	//catchall case since there is a temperature range where if we begin in that range it won't have a defined heating state. I am making it default to idle here basically
					heating = 0;
					cooling = 0;
				end
			end
		end
	end

	
endmodule
