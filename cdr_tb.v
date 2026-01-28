`timescale 1ns/10ps
module cdr_tb;

  reg refclk;    // fixed in this implementation to 1 GHz
  reg rx;       // asynchronous input from the RX-pad
  reg [127:0] control;
  
  wire [9:0] word_final;
  wire word_clock_final;
  wire [127:0] status;

  cdr cdr(refclk,rx,control,word_final,word_clock_final,status);


  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(4,cdr_tb);
      $display("Hello cdr!");
    end

  initial
    begin
      refclk = 0;
      rx = 0;
      control[0]=0;
      control[25:16] = 10'b0011111000;
      control[26]=1;
    end 

  always #0.5  refclk =  ! refclk;
  
  initial
    begin
      #10  rx = 1; // phase 0 will be the first to see this - the few first bits may safely be discarded
      #1   rx = 1;
      #1   rx = 0;
      #1   rx = 0;
      #1   rx = 1;
      #1   rx = 1;
      #1   rx = 1;
      #1   rx = 1;
      #1   rx = 1;
      #1   rx = 0;
      #1   rx = 0;
      #1   rx = 0;
      while (1) #1   rx = $random;
    end
  
  initial
    begin
      #2 control[0] = 1;
    end
  
  initial #40  $finish;

endmodule