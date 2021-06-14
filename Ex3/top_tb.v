//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #3 - Active IoT Devices Monitor
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex3 - Active IoT Devices Monitor
// Guidance: start with simple tests of the module (how should it react to each 
// control signal?). Don't try to test everything at once - validate one part of 
// the functionality at a time.
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
	//Todo: Parameters
	parameter CLK_PERIOD = 10;

	//Todo: Regitsers and wires
	reg clk;
	reg [2:0] data; // the msb is rst, middle bit is change, lsb is on_off
	wire [7:0] counter_out;
	reg err;
	reg [7:0] previous;
	reg [7:0] numcycles;

	//Todo: Clock generation
    	initial begin	//this sets the clock going from the start

    	   clk = 1'b0;
    	   forever
    	     #(CLK_PERIOD/2) clk=~clk;
    	end
	//Todo: User logic
		initial begin
		data = 3'b0;		//starting the values sent in as 0s
		err = 1'b0;
		previous = 8'b0;
		numcycles = 8'b0;
			forever begin
			 
			#CLK_PERIOD;
			if ((data[2] == 1) && (counter_out != 0)) begin
				err = 1;
				$display("Error in reset");
			end
			else begin
				if ((data[1] == 0) && (counter_out != previous)) begin
					err = 1;
	    			$display("Error in change");
				end
				else begin
					if ((data[0] == 1) && (counter_out != previous + 8'b1)) begin
						err = 1;
						$display("error in on_off, on");
					end
					else begin
						if ((data[0] == 0) && (counter_out != previous - 8'b1)) begin
							err = 1;
							$display("error in on_off, off");
						end
					end
				end
			end
			if (numcycles < 8'b00010100)begin
				data[2] = 1;
		    end
			else begin
			data[2] = 0;
				if((numcycles % 8'b00000101) == 0) begin
					data[1] = 1;
					data[2] = numcycles % 2;
				end
				else 
					data[1] = 0;
					data[0] = 0;
				endbegin
			end
			previous = counter_out;
			numcycles = numcycles + 8'b1;
			end
		end
	//Todo: Finish test, check for success
     	initial begin
        	#500
        	if (err==0)
          		$display("***TEST PASSED! :) ***");
        	$finish;
      	end
	
	//Todo: Instantiate counter module
 	monitor top (
	.rst  (data[2]),
	.change (data[1]),
	.on_off (data[0]),
	.clk (clk),
	.counter_out (counter_out));
endmodule 
