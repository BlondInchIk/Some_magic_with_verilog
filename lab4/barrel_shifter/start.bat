
rem recreate a temp folder for all the simulation files
rd /s /q sim
md sim
cd sim

rem compile verilog files for simulation
iverilog  ..\barrelShifter.v ..\barrelShifter_tb.v 
 pause

rem run the simulation
vvp -la.lst -n a.out -vcd

rem show the simulation results in GTKwave
gtkwave dump.vcd

rem return to the parent folder
cd ..
cmd