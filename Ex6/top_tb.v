//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #6 - RGB Colour Converter
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex6 - RGB Colour Converter
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps
module top_tb();
	
	//parameters
	
	parameter CLK_PERIOD = 10;
	
	
	//regs and wires
	reg clk;
	reg enable;
	reg [2:0] colour;
	reg err;
	wire [23:0] rgb;
	reg [23:0] previous;
	reg [23:0] result;
	
	//clock generator
	initial begin	//this sets the clock going from the start
   		clk = 1'b0;
    	forever begin
    	   #(CLK_PERIOD/2);
    	   clk=~clk;
    	end
    end
	
	//logic
	initial begin		//gives us something to test the enable with
		#(CLK_PERIOD>>1);
		forever begin
			previous = rgb;
			#CLK_PERIOD;
		end
	end
	
	initial begin
		err = 0;
		enable = 0;
		colour = 3'b001;		//testing the enable with something that would give a different result than 0
		result = 24'h00000000;
		#CLK_PERIOD;
		if (rgb != previous) begin
			$display("Error in enable");
			err = 1;
		end
		enable = 1;
		forever begin
			#CLK_PERIOD;
			if(enable) begin
				case(colour)					//this sets the expected values for the memory accesses for each colour
				3'b000: result <= 24'h000000;
				3'b001: result <= 24'h0000FF;
				3'b010:	result <= 24'h00FF00;
				3'b011: result <= 24'h00FFFF;
				3'b100: result <= 24'hFF0000;
				3'b101: result <= 24'hFF00FF;
				3'b110: result <= 24'hFFFF00;
				default: result <= 24'hFFFFFF;	//(for 3'b111)
				endcase
				if (result != rgb) begin
					$display("Error in memory access");
					err = 1;
				end
			end
			colour = colour + 3'b1;				//Cycling through the colours
		end
	end

	//final test
	initial begin
		#500
		 if (err==0) begin
          $display("***TEST PASSED! :) ***");
        $finish;
        end
    end
	
	
	//instantiate module
	converter top(
	.clk (clk),
	.colour (colour),
	.enable (enable),
	.rgb (rgb));



endmodule

