/////
//
//

`timescale 1ns / 100ps
module smarthome(
	input a,
    input b,
    input [3:0] func,
    output out,
    input change,
	input on_off,
	input rst,
	input clk,
	output [7:0] counter_out,
	output [1:0] direction,
	input sel,
	input button,
	output [23:0]light,
	input clk_p,
    input clk_n,
	input rst_n,
	input temperature_4,
	input temperature_3,
	input temperature_2,
	input temperature_1,
	input temperature_0,
	output heating,
	output cooling
	);
	
	blinds(
     .a(a),
     .b(b),
     .func(func),
     .out(out)
    );
    
	
	monitor (
	 .change(change),
	 .on_off(on_off),
	 .rst(rst),
	 .clk(clk),
	 .counter_out(counter_out),
	 .direction(direction)
    );
	
	doorbell(
	 .a(a),
	 .b(b),
	 .sel(sel),
	 .out(out)
    );
	
	lights (
	input .clk(clk),
	input .sel(sel),
	input .rst(rst),
	input .button(button),
	outpu .light(light)
	);
	
	ACunit(
    input .clk_p(clk),
    input .clk_n(~clk),
	input .rst_n(rst),
	input .temperature_4(temperature_4),
	input .temperature_3(temperature_3),
	input .temperature_2(temperature_2),
	input .temperature_1(temperature_1),
	input .temperature_0(temperature_0),
	output .heating(heating),
	output .cooling(cooling)
   );
	
	
endmodule
