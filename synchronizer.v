`timescale 1ns/10ps
module synchronizer(input clk, input data_in, output data_out);

  parameter STAGES=3; // minimum 1
  
  reg [(STAGES-1):0] chain;
  integer i;
  
  // due to the provision for the lenght of one, this cannot be presented in concatenated array form
  always @(posedge clk)
    begin
      chain[0] <= data_in;
      for (i=1;i<STAGES;i=i+1) chain[i] <= chain[i-1];
    end
  
  assign data_out = chain[STAGES-1];
  
endmodule