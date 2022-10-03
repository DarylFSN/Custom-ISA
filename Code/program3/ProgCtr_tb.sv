// Test bench
// Program Counter (Instruction Fetch)

module ProgCtr_tb;

timeunit 1ns/1ps;

// Define signals to interface with UUT
bit Reset;
bit Start;
bit Clk;
bit BranchAbsEn;
bit BranchRelEn;
bit ALU_flag;
bit [9:0] TargetOrOffset;
logic [9:0] NextInstructionIndex;

int fd;
int allTestsPassed;

// Instatiate and connect the Unit Under Test
ProgCtr uut (
  .Reset(Reset),
  .Start(Start),
  .Clk(Clk),
  .BranchAbsEn(BranchAbsEn),
  .ALU_flag(ALU_flag),
  .Target(TargetOrOffset),
  .ProgCtr(NextInstructionIndex)
);

integer ClockCounter = 0;
always @(posedge Clk)
  ClockCounter <= ClockCounter + 1;

// The actual testbench logic
//
// In this testbench, let's look at 'manual clocking'
initial begin
  // Time 0 values
  fd = $fopen("pc_transcript.txt", "w");
  $fdisplay(fd, "Initialize Testbench.");
  Reset = '1;
  Start = '0;
  Clk = '0;
  BranchAbsEn = '0;
  ALU_flag = '1;
  TargetOrOffset = '0;
  allTestsPassed = 'd1;

  // Advance to simulation time 1, latch values
  #1 Clk = '1;

  // Advance to simulation time 2, check results, prepare next values
  #1 Clk = '0;
  $fdisplay(fd, "Checking Reset behavior");
  assert (NextInstructionIndex == 'd0);
  if(NextInstructionIndex == 'd0) begin
      $fdisplay(fd, "Reset behavior test passed!");
  end else begin
      $fdisplay(fd, "Reset behavior test failed!");
      allTestsPassed = 'd0;
  end
  Reset = '0;

  // Advance to simulation time 3, latch values
  #1 Clk = '1;

  // Advance to simulation time 4, check results, prepare next values
  #1 Clk = '0;
  $fdisplay(fd, "Checking that nothing happens before Start");
  assert (NextInstructionIndex == 'd0);
  if(NextInstructionIndex == 'd0) begin
      $fdisplay(fd, "Pre-start behavior test passed!");
  end else begin
      $fdisplay(fd, "Pre-start behavior test failed!");
      allTestsPassed = 'd0;
  end
  Start = '1;

  // Advance to simulation time 5, latch values
  #1 Clk = '1;

  // Advance to simulation time 6, check results, prepare next values
  #1 Clk = '0;
  $fdisplay(fd, "Checking that nothing happened during Start");
  assert (NextInstructionIndex == 'd0);
  if(NextInstructionIndex == 'd0) begin
      $fdisplay(fd, "Start behavior test passed!");
  end else begin
      $fdisplay(fd, "Start behavior test failed!");
      allTestsPassed = 'd0;
  end
  Start = '0;

  // Advance to simulation time 7, latch values
  #1 Clk = '1;

  // Advance to simulation time 8, check outputs, prepare next values
  #1 Clk = '0;
  $fdisplay(fd, "Checking that first Start went to first program");
  assert (NextInstructionIndex == 'd000);
  if(NextInstructionIndex == 'd000) begin
      $fdisplay(fd, "Post-start behavior test passed!");
  end else begin
      $fdisplay(fd, "Post-start behavior test failed!");
      allTestsPassed = 'd0;
  end
  // No change in inputs

  // Advance to simulation time 9, latch values
  #1 Clk = '1;

  // Advance to simulation time 10, check outputs, prepare next values
  #1 Clk = '0;
  $fdisplay(fd, "Checking that no branch advanced by 1");
  assert (NextInstructionIndex == 'd001);
  if(NextInstructionIndex == 'd001) begin
      $fdisplay(fd, "Increment behavior test passed!");
  end else begin
      $fdisplay(fd, "Increment behavior test failed!");
      allTestsPassed = 'd0;
  end
  BranchAbsEn = '1;
  TargetOrOffset = 'd10;

  // Latch, check, setup next test
  #1 Clk = '1;
  #1 Clk = '0;
  $fdisplay(fd, "Checking that absolute branch went to target");
  assert (NextInstructionIndex == 'd10);
  if(NextInstructionIndex == 'd10) begin
      $fdisplay(fd, "Branch behavior test passed!");
  end else begin
      $fdisplay(fd, "Branch behavior test failed!");
      allTestsPassed = 'd0;
  end
  BranchAbsEn = '0;
  TargetOrOffset = 'd5;
  // note, ALU_flag still 0

  if(allTestsPassed == 'd1) begin
      $fdisplay(fd, "All checks passed.");
  end else begin
      $fdisplay(fd, "At least one check failed.");
  end
  $fclose(fd);
end

initial begin
  $dumpfile("ProgCtr.vcd");
  $dumpvars();
  $dumplimit(104857600); // 2**20*100 = 100 MB, plenty.
end

endmodule
