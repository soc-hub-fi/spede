`timescale 1ns/10ps
module filter_tb;

  reg masterclock;

  reg [9:0] word;
  reg word_clock;
  
  wire [9:0] word_final;
  wire word_clock_final;
  
  filter filt(masterclock,word,word_clock,word_final,word_clock_final);

  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(2,filter_tb);
      $display("Hello filter!");
    end

  initial
    begin
      word = 123;
      word_clock = 0;
      masterclock = 0;
    end 

  always #8  masterclock =  ! masterclock; 

  always #100  word_clock = ! word_clock;
  
  
  initial #4000  $finish;

endmodule