
// rx is the single bit input from the RX pad
// word and word_clock are final results
// control and status bits are used in mostly yet-to-be-defined ways

`timescale 1ns/10ps
module cdr(input bitclk, input rx, input [127:0] control, output [9:0] word, output word_clock, output [127:0] status);

  wire data,dataclock; // from sampler to wordsync

  wire [9:0] word_pre; // from wordsync to clock filter
  wire word_clock_pre;

  sampler sam(bitclk, rx, data, dataclock, control[63:32], status[1:0]);

  wordsync ws(dataclock,control[0],data,control[25:16],control[26],word_pre,word_clock_pre);
  
  filter filt(bitclk,word_pre,word_clock_pre,word,word_clock);
  
endmodule