`timescale 1ns / 100ps
module top_tb();


	//Parameters    
    parameter CLK_PERIOD = 10;
    
    
	//declare wires and regs
	reg clk;
    reg [1:0] ab;
    reg [3:0] func;
    reg err;
	wire out_1;
	
    reg [1:0] cd;
    reg [1:0] cd_prev;
    reg sel_1;
    wire out;
    
	reg rst_1;
	reg change;
	reg on_off;
	wire [7:0] counter_out;
	wire [1:0] direction;
	
	reg sel;
	reg rst;
	reg button;
	wire [23:0] light;
	reg [23:0] previous;
	
	reg [4:0] temperature;
	wire heating;
	wire cooling;
	reg [1:0] state;
	reg clk_p;
	reg rst_n = 1'b0;
	wire clk_n = ~clk_p;
	
	//clock generation
	initial begin	//this sets the clock going from the start
   		clk_p = 1'b1;
   		clk = 1'b0;
    	forever begin
    	   #(CLK_PERIOD/2);
    	   clk_p=~clk_p;
    	   clk =~clk;
    	end
    end
	
	//logic
	
	
	//1

	initial begin
       ab=0;
       err=0;
       func=4'hA;
       forever begin
         #CLK_PERIOD
         if ((out_1==1'h1) || (out_1==1'b0)) begin
           if (out_1!=func[{ab}])
           begin
             $display("***TEST FAILED! a==%d, b==%d, func='0xA', expected out_1=%d, actual out_1=%d ***",ab[1],ab[0],func[ab],out_1);
             err=1;
           end
         end 
         else begin
           $display("***TEST FAILED! out_1 is %b. Have you written any code yet?***",out_1);
           err=1;
         end
         ab=ab+1;
       end
     end
	
	//2
	  
    initial begin
       cd=0;
       cd_prev=cd;
       err=0;
       sel_1=0;
       #6
       forever begin
         #(CLK_PERIOD-6)
	 if ((sel_1&(out!=cd_prev[0]))| (!sel_1&(out!=cd_prev[1])))
         begin
           $display("***TEST FAILED! did not maintain 5 ticks gap! c=%d, d=%d, previous c=%d, previous d=%d, sel_1=%d, actual out=%d ***",cd[1],cd[0],cd_prev[1], cd_prev[0], sel_1,out);
           err=1;
         end
         #6
	 if ((sel_1&(out!=cd[0]))| (!sel_1&(out!=cd[1])))
         begin
           $display("***TEST FAILED! c==%d, d==%d, sel_1='%d', actual out=%d ***",cd[1],cd[0],sel_1,out);
           err=1;
         end
	 cd_prev=cd;
         cd=cd+1;
         if (cd==0)
           sel_1=~sel_1;
       end
     end
	
	//3
	
		initial begin		//this sets the data stream in to test
			forever begin
			rst_1 = 1;
			change = 1;
			on_off = 1;
			#(4*CLK_PERIOD);
			rst_1 = 0;
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
				if (rst_1) begin
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
	
	//7	
	
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
	
	//8
	
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
		#(CLK_PERIOD);
		#(CLK_PERIOD>>1);
		if((heating != 0) && (cooling != 1)) begin
			$display("Error with being in cooling state");
			err=1;
		end
		
		temperature = 5'b10100;
		#(CLK_PERIOD<<1);
		if(state != 2'b00) begin
			$display("Error with being in idle state");
			err = 1;
		end
		
		temperature = 5'b00000;
		#(CLK_PERIOD<<1);
		if(state != 2'b10) begin
			$display("Error with being in heating state");
			err = 1;
		end
		
		
		forever begin				//I'll just have it cycle temperatures from 0 to 31 and wrap around to check it works
			#CLK_PERIOD;
			temperature = temperature + 5'b1;
			if (temperature == 5'b11110) begin
				temperature = 5'b10011;
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
	
	
	//instantiate module
	smarthome mysmarthome(
	.a (ab[1]),
    .b (ab[0]),
    .func (func),
    .out_1 (out_1),
    .rst_1  (rst_1),
	.change (change),
	.on_off (on_off),
	.clk (clk),
	.counter_out (counter_out),
	.direction (direction),
	.c(cd[1]),
	.d(cd[0]),
	.sel_1(sel_1),
	.out(out),
	.sel (sel),
	.rst (rst),
	.button (button),
	.light (light),
	.clk_n (clk_n),
    .clk_p (clk_p),
    .rst_n (rst_n),
    .temperature_4 (temperature[4]),
    .temperature_3 (temperature[3]),
    .temperature_2 (temperature[2]),
    .temperature_1 (temperature[1]),
    .temperature_0 (temperature[0]),
    .heating (heating),
    .cooling (cooling)
	);
	
	
endmodule
