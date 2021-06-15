//////////////////////////////////////////////////////////////////////////////////
// Exercise #3 - Active IoT Devices Monitor
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to design a counter of active IoT devices, where 
//  if the rst=1, the counter should be set to zero. If event=0, the value
//  should stay constant. If on-off=1, the counter should count up every
//  clock cycle, otherwise it should count down.
//  Wrap-around values are allowed.
//
//  inputs:
//           clk, rst, change, on_off
//
//  outputs:
//           counter_out[7:0]
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module monitor (
    //Todo: add ports 
	input change,
	input on_off,
	input rst,
	input clk,
	output reg [7:0] counter_out,
	output reg [1:0] direction
    );
                    
    //Todo: add registers and wires, if needed

    //Todo: add user logic
    initial begin
    counter_out = 8'b0;
    direction = 2'b0;
    end
	always @ (posedge clk) begin
		if (rst) begin
			counter_out <= 8'b0;
		end
		else begin 
			if (change) begin
      			if (on_off) begin
         			direction = 2'b01;
         			counter_out <= counter_out + 8'b1;
      			end
      			else begin
         			direction = 2'b10;
         			counter_out <= counter_out - 8'b1;
      			end
      		end
      		else begin
    	  		direction = 2'b00;
    	  		counter_out <= counter_out;
    	  	end
   		end
	end
endmodule
