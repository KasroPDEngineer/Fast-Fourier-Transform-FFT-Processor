set log file logs/FFT_lec.log -replace
read library /home/vlsitech_01/training_block/Cadence-RTL-to-GDSII-Flow-main/LIB/slow_vdd1v0_basiccells.v -verilog -both; // [verilog functional model used .v]
read design  /home/vlsitech_01/training_block/Cadence-RTL-to-GDSII-Flow-main/kasro/RTL/FFT.v -verilog -golden
read design  /home/vlsitech_01/training_block/Cadence-RTL-to-GDSII-Flow-main/kasro/FFT/SYN/outputs/FFT_netlist.v -verilog -revised
add pin constraints 0 SE  -revised
add ignored inputs scan_in -revised
add ignored outputs scan_out -revised
set system mode lec
add compared point -all
compare

