`timescale 1ns/ 1ps

// Test bench
// Arithmetic Logic Unit

//;
// INPUT: A, B
// op: 000, A ADD B
// op: 100, A_AND B
// ...
// Please refer to definitions.sv for support ops (make changes if necessary)
// OUTPUT A op B
// equal: is A == B?
// even: is the output even?
//

module ALU_tb;

// Define signals to interface with the ALU module
logic [ 7:0] INPUTA;  // data inputs
logic [ 7:0] INPUTB;
logic [ 2:0] op;      // ALU opcode, part of microcode
bit SC_IN = 'b0;
wire[ 7:0] OUT;
wire Zero;

// Define a helper wire for comparison
logic [ 7:0] expected;

int fd;

// Instatiate and connect the Unit Under Test
ALU uut(
  .InputA(INPUTA),
  .InputB(INPUTB),
  .SC_in(SC_IN),
  .OP(op),
  .Out(OUT),
  .Zero(Zero)
);


// The actual testbench logic
initial begin
  fd = $fopen("alu_transcript.txt", "w");
  INPUTA = 1;
  INPUTB = 1;
  op= 'b000; // ADD
  test_alu_func; // void function call
  #5;

  INPUTA = 4;
  INPUTB = 1;
  op= 'b001; // AND
  test_alu_func; // void function call
  #5;

  INPUTA = 5;
  INPUTB = 5;
  op= 'b010; // XOR
  test_alu_func; // void function call
  #5;

  INPUTA = 4;
  INPUTB = 1;
  op= 'b011; // SRL
  test_alu_func; // void function call
  #5;

  $fclose(fd);
end

task test_alu_func;
  case (op)
    0: expected = INPUTA + INPUTB;      // ADD
    1: expected = INPUTA & INPUTB;      // AND
    2: expected = INPUTA ^ INPUTB;      // XOR
    3: expected = {1'b0, INPUTA[7:1]};  // SRL
  endcase
  #1;
  if(expected == OUT) begin
    $fdisplay(fd, "%t YAY!! inputs = %h %h, opcode = %b, Zero %b",$time, INPUTA,INPUTB,op, Zero);
  end else begin
    $fdisplay(fd, "%t FAIL! inputs = %h %h, opcode = %b, zero %b",$time, INPUTA,INPUTB,op, Zero);
  end
endtask

initial begin
  $dumpfile("alu.vcd");
  $dumpvars();
  $dumplimit(104857600); // 2**20*100 = 100 MB, plenty.
end

endmodule
