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
	reg rst;
	reg change;
	reg on_off;
	wire [7:0] counter_out;
	reg err;
	wire [1:0] direction;

	//Todo: Clock generation
    	initial begin	//this sets the clock going from the start

    	   clk = 1'b0;
    	   forever
    	     #(CLK_PERIOD/2) clk=~clk;
    	end
	//Todo: User logic
		initial begin		//this sets the data stream in to test
			forever begin
			rst = 1;
			change = 1;
			on_off = 1;
			#(4*CLK_PERIOD);
			rst = 0;
			on_off = 1;
			#(5*CLK_PERIOD);
			on_off = 0;
			#(7*CLK_PERIOD);
			change = 0;
			#(5*CLK_PERIOD);		
			end
		end
		initial begin
			err = 0; // start with no errors
			#(CLK_PERIOD);
			forever begin
				if (rst) begin
					#(CLK_PERIOD)
					if(counter_out) begin
						$display("Error in Reset");
						err = 1;
					end
				end
				else begin
					#(CLK_PERIOD)
					if(~change) begin
						#(CLK_PERIOD)
						if (direction != 2'b00) begin
							$display("Error in change");
							err = 1;
						end
					end
					else begin
						#(CLK_PERIOD)
						if(on_off) begin
							#(CLK_PERIOD)
							if(direction != 2'b01) begin
								$display("Error in on_off, on");
								err = 1;
							end
						end
						else begin
							#(CLK_PERIOD)
							if(~on_off) begin
								#(CLK_PERIOD)
								if(direction != 2'b10) begin
									$display("Error in on_off, off");
									err = 1;
								end
							end
						end
					end
				end
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
	.rst  (rst),
	.change (change),
	.on_off (on_off),
	.clk (clk),
	.counter_out (counter_out),
	.direction (direction));
endmodule 
