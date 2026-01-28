`timescale 1ns/10ps
module phase_gen(input clk, output reg [7:0]phase, input [31:0] C, output [1:0] S);
  always @(clk) begin

  phase[0] <= #0.125 clk; 
  phase[1] <= #0.250 clk; 
  phase[2] <= #0.375 clk;
  phase[3] <= #0.500 clk;
  phase[4] <= #0.625 clk;
  phase[5] <= #0.750 clk;
  phase[6] <= #0.875 clk;
  phase[7] <= #1.000 clk;

  end 
  
  assign S[0]=0;
  assign S[1]=0;

endmodule