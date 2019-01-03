module fsmCPU (ACK, clk, rst, outDATA,outSEND);	
	output reg outSEND;
  	output reg [31:0] outDATA;

	input ACK;
  	input clk, rst;
	
	/*
		CPU states:
		0 - not sending
		1 - sending
	*/
	reg currentState, nextState;

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
				if (ACK == 0)
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
			begin
				outSEND = 0;
			end
			1:
			begin
				outSEND = 1;
				// Generates a random 32-bit number
				outDATA = $random;
			end
			
		endcase
	end

endmodule