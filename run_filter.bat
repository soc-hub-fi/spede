
@echo.
@echo.
@echo                          STARTING!
@echo.

del mydesign
iverilog -v -o mydesign filter_tb.v filter.v

vvp mydesign

gtkwave dump.vcd &