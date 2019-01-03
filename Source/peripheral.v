module fsmPeripheral (SEND, clk, rst, inputData, outACK);
	output reg outACK;

	input SEND;
  	input clk, rst;
  	input [31:0] inputData;

	/*
		Peripheral states:
		0 - not receiving
		1 - receiving
	*/
	reg currentState, nextState;
  	reg [31:0] data;


	// Current State
	always @ (posedge clk)
	begin
		if (rst == 1)
			currentState <= 0;
		else
			currentState <= nextState;
	end

	// Next State
	always @ (*)
	begin
		case ({currentState})
			0, 1:
				if (SEND == 1)
					nextState = 1;
				else
					nextState = 0;
		endcase
	end

	// Outputs
	always @ (*)
	begin
		case ({currentState})	
			0:
				outACK = 0;
			1:
			begin
				data = inputData;
				outACK = 1;
			end
		endcase
	end

endmodule