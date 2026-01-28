`timescale 1ns/10ps
module phaser(input clk, input rx, input opposite_sampleA, input opposite_sampleB, input opposite_claim, output reg sample, output reg claim, output data, output dataclock);

  reg [1:0] sync;
  reg [5:0] transition;
  
  assign data = sample & claim;
  assign dataclock = clk & opposite_claim; // the opposite phase claim

  // make claim
  always @(posedge clk)
    begin
      sync[0] <= rx;
      sync[1] <= sync[0];
      sample <= sync[1];

      transition[5:0] <= {transition[4:0],opposite_sampleA ^ opposite_sampleB};
      claim <= |{transition[5:0],opposite_sampleA ^ opposite_sampleB};
    end
  
endmodule