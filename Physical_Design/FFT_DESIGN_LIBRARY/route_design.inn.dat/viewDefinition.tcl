if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name fft_fast\
   -timing\
    [list ${::IMEX::libVar}/mmmc/fast_vdd1v0_basicCells.lib]
create_library_set -name fft_slow\
   -timing\
    [list ${::IMEX::libVar}/mmmc/slow_vdd1v0_basiccells.lib]
create_rc_corner -name rc_corner\
   -cap_table ${::IMEX::libVar}/mmmc/cln28hpl_1p10m+alrdl_5x2yu2yz_typical.capTbl\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0
create_delay_corner -name delay_corner_fft_slow\
   -library_set fft_slow\
   -rc_corner rc_corner
create_delay_corner -name delay_corner_fft_fast\
   -library_set fft_fast\
   -rc_corner rc_corner
create_constraint_mode -name functional_fft_slow\
   -sdc_files\
    [list ${::IMEX::dataVar}/mmmc/modes/functional_fft_slow/functional_fft_slow.sdc]
create_constraint_mode -name functional_fft_fast\
   -sdc_files\
    [list ${::IMEX::dataVar}/mmmc/modes/functional_fft_fast/functional_fft_fast.sdc]
create_analysis_view -name view_fft_fast -constraint_mode functional_fft_fast -delay_corner delay_corner_fft_fast -latency_file ${::IMEX::dataVar}/mmmc/views/view_fft_fast/latency.sdc
create_analysis_view -name view_fft_slow -constraint_mode functional_fft_slow -delay_corner delay_corner_fft_slow -latency_file ${::IMEX::dataVar}/mmmc/views/view_fft_slow/latency.sdc
set_analysis_view -setup [list view_fft_slow] -hold [list view_fft_fast]
catch {set_interactive_constraint_mode [list functional_fft_slow functional_fft_fast] } 
