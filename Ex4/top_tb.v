//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #4 - Dynamic LED lights
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex4 - Dynamic LED lights
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps
module top_tb();

	//parameters
	parameter CLK_PERIOD = 10;
	
	//regs and wires
	reg clk;
	reg rst;
	reg button;
	reg err;
	wire [2:0] colour;
	reg [2:0] prev;
	
	//clock
	initial begin	//this sets the clock going from the start
   		clk = 1'b0;
    	forever begin
    	   #(CLK_PERIOD/2);
    	   clk=~clk;
    	end
    end
	//logic
	initial begin	//sending the data stream
		err = 0;
		rst = 1;
		button = 0;
		#CLK_PERIOD;
		if(colour == 3'b000 || colour == 3'b111) begin
			;
		end
		else begin
			$display("Test Failed reset on");
			err =1;
			$finish;
		end
		
		rst = 0;
		#CLK_PERIOD;
		button = 1;
		#(CLK_PERIOD*20);
		button = 0;
		#(CLK_PERIOD*15);
		forever begin
			#CLK_PERIOD;
			if(button) begin
				if(colour != (prev + 3'b1)) begin
					if (colour != 3'b001) begin
						$display("Test Failed button on");
						err = 1;
						$finish;
					end
				end
			end
			else begin
				#CLK_PERIOD;
				if (colour != prev) begin
					$display("Test Failed button off");
					err = 1;
					$finish;
				end
			end
		end	
	end
	always @ (negedge rst) begin
		#CLK_PERIOD;
		if (colour != 3'b001) begin
			$display("Test Failed reset off");
			err = 1;
			//$finish;
		end
	end
	
	initial begin			//sets up the measurement for the previous colour
		#(CLK_PERIOD>>1);
		forever begin
			prev = colour;
			#CLK_PERIOD;
		end
	end
		
			
	//final test
	initial begin
        #100
        if (err==0) begin
          $display("***TEST PASSED! :) ***");
        $finish;
        end
    end
    
    
    
	//instantiate module
	lights top (
	.clk (clk),
	.rst (rst),
	.button (button),
	.colour (colour));
	
endmodule
