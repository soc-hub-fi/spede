
// edited 04.03.2023 to remove the handshaking with the outgoing data
// now the output word can be clocked with the rising edge of word_clock_final

`timescale 1ns/10ps
module wordsync(input clk, input reset_n, input data, input [9:0] sync_word, input sync_inverse, output reg [9:0] word, output word_clock_final);

  reg [9:0] shift;
  reg [3:0] count;
  reg [4:0] shift_clock;

  reg sync_acquired;
  
  reg word_clock;

  reg reset_sync;
  reg master_reset;
  
  assign word_clock_final = shift_clock[4];

  // assure synchronous release of the asynchronous reset
  always @(posedge clk or negedge reset_n)
    if (!reset_n)
      begin
        master_reset <= 0;
        reset_sync <= 0;
      end
    else
      begin
        master_reset <= reset_sync;
        reset_sync <= 1;
      end
  
  always @(posedge clk or negedge master_reset)
    begin
      
      if (!master_reset)
        begin
          sync_acquired <= 0;
          count <= 0;
          shift <= 0;
          shift_clock <= 0;
          word <= 0;
          word_clock <= 0;
        end
      
      else
        begin
        shift <= {shift[8:0],data};

        shift_clock <= {shift_clock[3:0],word_clock};
          if ((shift==sync_word) || ((shift==~sync_word)&&sync_inverse) || (count==9))
            begin
              sync_acquired <= 1;
              count <= 0;
              word <= shift;
              word_clock <= 1;
            end
          else
            begin
              if (sync_acquired) count <= count + 1;
              if (count==4) word_clock <= 0;
            end
          
        end          

    end
  
endmodule