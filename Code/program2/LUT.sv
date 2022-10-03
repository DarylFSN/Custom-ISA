// Design Name:    CSE141L
// Module Name:    LUT

// possible lookup table for PC target
// leverage a few-bit pointer to a wider number
// Lookup table acts like a function: here Target = f(Addr);
// in general, Output = f(Input)
//
// Lots of potential applications of LUTs!!

// You might consider parameterizing this!
module LUT(
  input 			[ 7:0] Addr,
  output logic [ 9:0] Target
);

always_comb begin

  case(Addr)
    4'd0: Target = 10'h001; 	// LOOP
    4'd1: Target = 10'h1B7;	// SHIFT_LOW
    4'd2: Target = 10'h1C0;	// SHIFT_HIGH
    4'd3: Target = 10'h1CD;	// SHIFT_LOW_DONE
    4'd4: Target = 10'h1D4;	// SHIFT_HIGH_DONE
    4'd5: Target = 10'h1D6;	// SHIFT_DONE
    4'd6: Target = 10'h1F8;	// FLAG_IF_ELSE
    4'd7: Target = 10'h1FD;	// FLAG_ELSE
    4'd8: Target = 10'h200;	// FLAG_DONE
	 default: Target = 10'bxxxxx_xxxxx;
  endcase
end

endmodule
