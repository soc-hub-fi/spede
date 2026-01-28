
// didn't have time+energy to make this parametrized
// three is a very good sync chain depth, anyway

`timescale 1ns/10ps
module filter(input clk, input [9:0] word_in, input word_clock_in,  output reg [9:0] word_out, output word_clock_out);

  reg [9:0] word_sync_1;
  reg [9:0] word_sync_2;
  reg [9:0] word_sync_3;

  reg clock_sync_1,clock_sync_2,clock_sync_3;
  
  reg [3:0] clock_filter;

  initial // this makes simulations possible without reset signal
    begin
       #10 clock_filter = 0; 
    end

  assign word_clock_out = clock_filter[0];

  always @(posedge clk)
    begin
      word_out    <= word_sync_3;
      word_sync_3 <= word_sync_2;
      word_sync_2 <= word_sync_1;
      word_sync_1 <= word_in;

      clock_sync_3 <= clock_sync_2;
      clock_sync_2 <= clock_sync_1;
      clock_sync_1 <= word_clock_in;

      clock_filter[3:1] <= clock_filter[2:0];

      if ((clock_filter==15) || (clock_filter==0))
        begin
          clock_filter[0] <= clock_sync_3;
        end
      else
        begin
          clock_filter[0] <= clock_filter[0];
        end

    end
  
endmodule