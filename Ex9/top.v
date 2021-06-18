/////
//
//

`timescale 1ns / 100ps
module smarthome(
	input a,
    input b,
    input [3:0] func,
    output out_1,
    input change,
	input on_off,
	input rst_1,
	input clk,
	output [7:0] counter_out,
	output [1:0] direction,
	input c,
	input d,
	input sel_1,
	output out,
	input sel,
	input rst,
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
	
	blinds myblinds(
     .a(a),
     .b(b),
     .func(func),
     .out(out)
    );
    
	
	monitor mymonitor(
	 .change(change),
	 .on_off(on_off),
	 .rst(rst_1),
	 .clk(clk),
	 .counter_out(counter_out),
	 .direction(direction)
    );
	
	doorbell mydoorbell(
	 .a(c),
	 .b(d),
	 .sel(sel_1),
	 .out(out)
    );
	
	lights mylights(
	 .clk(clk),
	 .sel(sel),
	 .rst(rst),
	 .button(button),
	 .light(light)
	);
	
	ACunit myACunit(
     .clk_p(clk_p),
     .clk_n(clk_n),
	 .rst_n(rst_n),
	 .temperature_4(temperature_4),
	 .temperature_3(temperature_3),
	 .temperature_2(temperature_2),
	 .temperature_1(temperature_1),
	 .temperature_0(temperature_0),
	 .heating(heating),
	 .cooling(cooling)
   );
	
	
endmodule
