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
		rst = 1;
		button = 0;
		#CLK_PERIOD;
		forever begin
			rst = 0;
			#CLK_PERIOD;
			button = 1;
			#(10*CLK_PERIOD);
			button = 0;
			#(2*CLK_PERIOD);
			rst = 1;
			#CLK_PERIOD;
		end	
	end
	
	initial begin			//sets up the measurement for the previous colour
		#(CLK_PERIOD>>1);
		forever begin
			prev = colour;
			#CLK_PERIOD;
		end
	end
	
	initial begin		//this will detect the errors
		err = 0;
		forever begin
			#(CLK_PERIOD>>1);
			err = 0;
			if(rst) begin
				#CLK_PERIOD;
				if(colour != 001)begin
					err = 1;
					$display("Error with reset");
				end
			end
			else begin
				#CLK_PERIOD;
				if(colour == 3'b000 || colour == 3'b111) begin
					err = 1;
					$display("Error with unused colour");
				end
				if(~button) begin
					#CLK_PERIOD;
					if (colour != prev) begin
						$display("Error with button off");
						err = 1;
					end
				end
				else begin
					#(CLK_PERIOD>>1);
					if (colour != (prev + 3'b1)) begin
						#(CLK_PERIOD>>1);
						case(colour)
						(3'b001): ;
						default: begin 
							err = 1;
							$display("Error with button on");
							end
						endcase
					end
				end
			end
		end
	end
			
	//final test
	initial begin
        #1000
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
