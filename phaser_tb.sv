`timescale 1ns/10ps
module phaser_tb;

  reg clk;
  reg rx;
  reg oppositeA, oppositeB;
  reg [6:0] otherclaims;

  wire sample,data,dataclock,claim;
  
  phaser #(.SYNC_STAGES(3)) dut(.clk (clk),
                                .rx (rx),
                                .oppositeA (oppositeA),
                                .oppositeB (oppositeB),
                                .otherclaims (otherclaims),
                                .sample (sample),
                                .data (data),
                                .dataclock (dataclock),
                                .claim (claim));
  
  initial
    begin
    $dumpfile("dump.vcd");
      $dumpvars(1,phaser_tb);
      $display("Hello phaser!");
    end

  initial
    begin
    clk = 0;
    rx = 0;
    oppositeA = 0;
    oppositeB = 0;
    otherclaims = 7'b0000000;
    end 

  always  
    #1  clk =  ! clk; 

  initial
    begin
    #2    rx = 1;
    #10   oppositeA=1;
    #10   oppositeB=1;
    #10   otherclaims = 7'b0001000;
    end

  initial #50  $finish; 

endmodule
