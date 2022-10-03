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
    5'd0: Target = 10'h022;
    5'd1: Target = 10'h02d;
    5'd2: Target = 10'h039;
    5'd3: Target = 10'h04a;
    5'd4: Target = 10'h019;
    5'd5: Target = 10'h069;
    5'd6: Target = 10'h076;
    5'd7: Target = 10'h084;
    5'd8: Target = 10'h091;
    5'd9: Target = 10'h05a;
    5'd10: Target = 10'h0b9;
    5'd11: Target = 10'h0c4;
    5'd12: Target = 10'h0d0;
    5'd13: Target = 10'h0dd;
    5'd14: Target = 10'h0f5;
    5'd15: Target = 10'h10f;
    5'd16: Target = 10'h12b;
    5'd17: Target = 10'h149;
    5'd18: Target = 10'h0ac;
    5'd19: Target = 10'h162;
    5'd20: Target = 10'h16d;
    5'd21: Target = 10'h179;
    5'd22: Target = 10'h186;
    default: Target = 10'bxxxxx_xxxxx;
  endcase
end

endmodule
