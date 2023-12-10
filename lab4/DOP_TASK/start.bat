
rem recreate a temp folder for all the simulation files
rd /s /q sim
md sim
cd sim

rem compile verilog files for simulation
iverilog ..\shift_reg_with_display.v ..\led7.v ..\clk_divider.v ..\shift_reg.v ..\de10_lite.v ..\testbench.v 
 pause

rem run the simulation
vvp -la.lst -n a.out -vcd

rem show the simulation results in GTKwave
gtkwave dump.vcd

rem return to the parent folder
cd ..
cmd