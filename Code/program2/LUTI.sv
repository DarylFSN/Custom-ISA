// Design Name:    CSE141L
// Module Name:    LUT

// possible lookup table for PC target
// leverage a few-bit pointer to a wider number
// Lookup table acts like a function: here Target = f(Addr);
// in general, Output = f(Input)
//
// Lots of potential applications of LUTs!!

// You might consider parameterizing this!
module LUTI(
  input 			[ 3:0] Addr,
  output logic [ 7:0] Target
);

always_comb begin

  case(Addr)
    4'd0: Target = 8'd1;
    4'd1: Target = 8'd2;  
    4'd2: Target = 8'd4;  
    4'd3: Target = 8'd8;
    4'd4: Target = 8'd16;
    4'd5: Target = 8'd32;
    4'd6: Target = 8'd64;
    4'd7: Target = 8'd128;
    4'd8: Target = 8'd0;
    4'd9: Target = 8'd30;
    4'd10: Target = 8'd7;
	 4'd11: Target = -8'd1;
	 default: Target = 8'bxxxx_xxxx;
  endcase
end

endmodule
