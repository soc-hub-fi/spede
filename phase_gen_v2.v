`timescale 1ns/10ps
// fastclock is adjusted to be ~ 8 x refclock
// work in progress
module phase_gen_v2(input fastclk, input refclk, output reg [7:0]phase);
  
  always @(posedge fastclk)
  begin
    phase[0] <= refclk;
    phase[7:1] <= phase[6:0];
  end
  
endmodule