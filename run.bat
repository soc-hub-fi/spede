
@echo.
@echo.
@echo                          STARTING!
@echo.

del mydesign
iverilog -v -o mydesign wordsync_tb.v wordsync.v sampler.v phaser.v phase_gen.v synchronizer.v filter.v

vvp mydesign

gtkwave dump.vcd &