`timescale 1ns / 1ps

`include "cpu.v"
`include "peripheral.v"


module testbench;
	// Inputs
	reg cpuClock, perClock, reset;

	wire [0:0] ACK;
	wire [0:0] SEND;
	wire [31:0] DATA;

	// CPU's Unit Under Test (UUT)
	fsmCPU uutCPU(
		.ACK(ACK),   
		.clk(cpuClock),  
		.rst(reset),
		.outDATA(DATA),
		.outSEND(SEND)
	);

	// Peripheral's Unit Under Test (UUT)
	fsmPeripheral uutPeripheral(
		.SEND(SEND),  
		.clk(perClock),  
		.rst(reset),
    	.inputData(DATA),
    	.outACK(ACK)
	);

initial begin
	$dumpfile("dump.vcd");
	$dumpvars;

	// Initialize Inputs
	cpuClock = 0;  
	perClock = 0;
	reset = 1;      
  
	// Wait 100 ns for global reset to finish
	#50;
	reset = 0;

  	#100;
  	
	$finish;
end  

always #7 perClock = !perClock;
always #5 cpuClock = !cpuClock;
  
endmodule