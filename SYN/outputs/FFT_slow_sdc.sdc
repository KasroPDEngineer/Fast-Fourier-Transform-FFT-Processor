# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.18-s082_1 on Sat Oct 18 10:54:46 EDT 2025

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design FFT

create_clock -name "clk" -period 8.0 -waveform {0.0 4.0} [get_ports clk]
set_clock_transition 0.1 [get_clocks clk]
set_clock_gating_check -setup 0.0 
set_clock_uncertainty -setup 0.01 [get_ports clk]
set_clock_uncertainty -hold 0.01 [get_ports clk]
