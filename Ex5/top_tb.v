//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #5 - Air Conditioning
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex5 - Air Conditioning
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps
module top_tb();

	//Parameters
	parameter CLK_PERIOD = 10;
	
	//wires and regs
	reg clk;
	reg [4:0] temperature;
	wire heating;
	wire cooling;
	reg [1:0] state;
	reg err;
	
	//clock generator
	initial begin	//this sets the clock going from the start
   		clk = 1'b0;
    	forever begin
    	   #(CLK_PERIOD/2);
    	   clk=~clk;
    	end
    end
    
    //logic
	initial begin			//Stores the state of the device
		forever begin
			state[1] = heating;
			state[0] = cooling;
			#CLK_PERIOD;
			if(state == 2'b11) begin
				$display("Error invalid state");
				err = 1;
			end
		end
	end
	
	initial begin
		err = 0;
		temperature = 5'b11111;		//test for starting in cooling state
		#(CLK_PERIOD*3);
		if(state != 2'b01) begin
			$display("Error with beginning in cooling state");
			err=1;
		end
		
		temperature = 5'b10100;
		#(CLK_PERIOD<<1);
		if(state != 2'b00) begin
			$display("Error with beginning in idle state");
			err = 1;
		end
		
		temperature = 5'b00000;
		#(CLK_PERIOD<<1);
		if(state != 2'b10) begin
			$display("Error with beginning in heating state");
			err = 1;
		end
		
		
		forever begin				//I'll just have it cycle temperatures from 0 to 31 and wrap around to check it works
			#CLK_PERIOD;
			temperature <= temperature + 5'b1;
			if (temperature == 5'b11110) begin
				temperature <= 5'b10011;
			end
		end
				
	end
	
	//final test
	initial begin
        #(50*CLK_PERIOD);
        if (err==0) begin
          $display("***TEST PASSED! :) ***");
        $finish;
        end
    end
	
	//instancing the module
	
	heater top(
	.clk (clk),
	.temperature (temperature),
	.heating (heating),
	.cooling (cooling));	
	


endmodule
