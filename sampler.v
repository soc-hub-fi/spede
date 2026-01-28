`timescale 1ns/10ps
module sampler(input refclk, input rx, output data, output dataclock, input [31:0] C, output [1:0] S);
  
  //parameter SYNC_STAGES=3;
  
  wire [7:0] clock_phase;
  wire [7:0] sample;
  wire [7:0] claim;
  wire [7:0] phase_data;
  wire [7:0] phase_dataclock;
  
  
  phase_gen p (.clk (refclk),
               .phase (clock_phase),
               .C (C),
               .S (S));
  
  genvar i;
  generate
    for (i=0;i<8;i=i+1) begin
      phaser                              pha0 ( .clk (clock_phase[i]),
                                                 .rx (rx),
                                                 .opposite_sampleA (sample[(i+3)%8]),
                                                 .opposite_sampleB (sample[(i+4)%8]),
                                                 .opposite_claim (claim[(i+4)%8]),
                                                 .sample (sample[i]),
                                                 .claim (claim[i]),
                                                 .data (phase_data[i]),
                                                 .dataclock (phase_dataclock[i])
                                                 );
    end
  endgenerate

  assign data = |phase_data;
  assign dataclock = |phase_dataclock;
  
endmodule