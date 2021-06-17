//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #7 - Lights Selector
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex7 - Lights Selector
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps
module top_tb();

	//parameters
	parameter CLK_PERIOD = 10;
	
	//wires and regs
	reg err;
	reg clk;
	reg sel;
	reg rst;
	reg button;
	wire [23:0] light;
	reg [23:0] previous;
	
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
			previous = light;
			#CLK_PERIOD;
		end
	end

	
	initial begin		//testing the modules
		err = 0;
		sel = 0;
		rst = 0;
		#CLK_PERIOD;
		if (~sel) begin
			if(light != 24'hFFFFFF) begin
				err = 1;
				$display("Error with multiplexer");
			end
		end
		sel = 1;
		rst = 1;
		#(2*CLK_PERIOD);		//The module takes a little while to run so I gave it extra delay
		if (rst) begin
			#(2*CLK_PERIOD);
			if (light != 24'hFFFFFF) begin
				err = 1;
				$display("Error with reset");
			end
		end
		rst = 0;
		button = 0;
		#(2*CLK_PERIOD);
		if (light != previous) begin
			$display("Error in button");
			err = 1;
		end
		button = 1;
		forever begin
			sel = 1;
			button = 1;
			#(CLK_PERIOD);
			if(button) begin
				#(CLK_PERIOD);
				if (light == previous) begin
					$display("Error in changing colour");
					err = 1;
				end
			end
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
	
	//instantiate the module
	selector top(
		.clk (clk),
		.sel (sel),
		.rst (rst),
		.button (button),
		.light (light));
endmodule
