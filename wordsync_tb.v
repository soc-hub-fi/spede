`timescale 1ns/10ps
module wordsync_tb;

  reg clk8x;
  reg rx;
  reg reset_n;
  
  reg masterclock;

  wire data;
  wire dataclock;
  
  wire [9:0] word;
  wire word_clock;
  
  wire [9:0] word_final;
  wire word_clock_final;

  sampler #(.SYNC_STAGES(3)) sam(clk8x, rx, data, dataclock);
  
  wordsync ws(dataclock,reset_n,data,10'b0011111000,1'b1,word,word_clock);
  
  filter filt(masterclock,word,word_clock,word_final,word_clock_final);

  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(2,wordsync_tb);
      $display("Hello wordsync!");
    end

  initial
    begin
      clk8x = 0;
      masterclock = 0;
      rx = 0;
    end 

  always #1  clk8x =  ! clk8x;

  always #8  masterclock =  ! masterclock; 
  
  initial
    begin
      #104  rx = 1; // phase 0 will be the first to see this - the few first bits may safely be discarded
      #16   rx = 1;
      #16   rx = 0;
      #16   rx = 0;
      #16   rx = 1;
      #16   rx = 1;
      #16   rx = 1;
      #16   rx = 1;
      #16   rx = 1;
      #16   rx = 0;
      #16   rx = 0;
      #16   rx = 0;
      while (1) #16   rx = $random;
    end
  
  initial
    begin
      reset_n = 0;
      #20 reset_n = 1;
    end
  
  initial #800  $finish;

endmodule