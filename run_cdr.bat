
@echo.
@echo.
@echo                          STARTING!
@echo.

del mydesign
del dump.vcd

iverilog -v -o mydesign cdr_tb.v cdr.v wordsync.v sampler.v phaser.v phase_gen.v synchronizer.v filter.v

vvp mydesign

gtkwave dump.vcd &