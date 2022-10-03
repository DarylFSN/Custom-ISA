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
    4'd0: Target = 10'd1; 	// 0x001
	 4'd1: Target = 10'd2;
	 default: Target = 10'bxxxxx_xxxxx;
  endcase
end

endmodule
