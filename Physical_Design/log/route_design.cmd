#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Wed Oct  8 17:12:39 2025                
#                                                     
#######################################################

#@(#)CDS: Innovus v22.10-p001_1 (64bit) 09/29/2022 11:03 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: NanoRoute 22.10-p001_1 NR220915-0329/22_10-UB (database version 18.20.590) {superthreading v2.19}
#@(#)CDS: AAE 22.10-p002 (64bit) 09/29/2022 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: CTE 22.10-p004_1 () Sep  7 2022 21:57:29 ( )
#@(#)CDS: SYNTECH 22.10-p001_1 () Aug  8 2022 11:26:34 ( )
#@(#)CDS: CPE v22.10-p005
#@(#)CDS: IQuantus/TQuantus 21.2.0-s201 (64bit) Wed Jul 6 19:14:09 PDT 2022 (Linux 3.10.0-693.el7.x86_64)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
getVersion
define_proc_arguments ViaFillQor -info {This procedure extracts Viafill details from innovus db} -define_args {
		{-window "window coordinates" "" list optional}
		{-window_size "window size in microns" "" string optional}
	
	}
define_proc_arguments ProcessFills -info {This procedure processes Fill types} -define_args {
    {-fillInfo "Design Fill data" "" list required}
				{-csvName "File path for Fill Data csv file" "Path of CSV file" string required}
				{-selectFill "type of fill to be selected in session" "list of BRIDGE/EXTENSION/STAMP/FLOATING" list required}
    {-output_data "Boolean Flag to output Fill Data for further processing" "" string required}
}
define_proc_arguments FillQor -info {This procedure extracts fill details from innovus db} -define_args {
    {-layers "Fills Cleanup on which all layers" "list of Metal/Routing layers" list optional}
				{-selectFill "type of fill to be selected in session" "list of BRIDGE/EXTENSION/STAMP/FLOATING" list optional}
				{-outData "Boolean Flag to output Fill Data for further processing" "" boolean optional}
    {-outDataFile "File path for Fill Data csv file" "Path of CSV file" string optional}
}
define_proc_arguments ProcessFills_fast -info {This procedure processes Fill types} -define_args {
    {-fillInfo "Design Fill data" "" list required}
				{-csvName "File path for Fill Data csv file" "Path of CSV file" string required}
				{-selectFill "type of fill to be selected in session" "list of BRIDGE/EXTENSION/STAMP/FLOATING" list required}
    {-output_data "Boolean Flag to output Fill Data for further processing" "" string required}
}
define_proc_arguments FillQor_fast -info {This procedure extracts fill details from innovus db} -define_args {
    {-layers "Fills Cleanup on which all layers" "list of Metal/Routing layers" list optional}
				{-selectFill "type of fill to be selected in session" "list of BRIDGE/EXTENSION/STAMP/FLOATING" list optional}
				{-outData "Boolean Flag to output Fill Data for further processing" "" boolean optional}
    {-outDataFile "File path for Fill Data csv file" "Path of CSV file" string optional}
}
define_proc_arguments ProcessFills_fast_stampOnly -info {This procedure processes Fill types} -define_args {
    {-fillInfo "Design Fill data" "" list required}
	
}
define_proc_arguments FillQor_fast_stampOnly -info {This procedure extracts fill details from innovus db} -define_args {
    {-layers "Fills Cleanup on which all layers" "list of Metal/Routing layers" list optional}
}
setDesignMode -process 45
restoreDesign FFT_DESIGN_LIBRARY/clock_opt.inn.dat FFT
all_constraint_modes -active
set_interactive_constraint_modes [all_constraint_modes -active]
current_design
set_max_capacitance $MAX_CAP [current_design]
set_propagated_clock [all_clocks]
reset_clock_uncertainty -from [all_clocks] -to [all_clocks]
set_clock_uncertainty -setup $SETUP_CLOCK_UNCERTAINTY [all_clocks]
set_clock_uncertainty -hold $HOLD_CLOCK_UNCERTAINTY [all_clocks]
update_constraint_mode -name functional_fft_slow -sdc_files $FUNC_SDC
create_library_set -name fft_slow -timing {/home/vlsitech_01/Cadence-RTL-to-GDSII-Flow-main/LIB/slow_vdd1v0_basiccells.lib}
create_library_set -name fft_fast -timing {/home/vlsitech_01/Cadence-RTL-to-GDSII-Flow-main/LIB/fast_vdd1v0_basicCells.lib}
create_rc_corner -name rc_corner -cap_table {/home/vlsitech_01/Cadence-RTL-to-GDSII-Flow-main/Captable/cln28hpl_1p10m+alrdl_5x2yu2yz_typical.capTbl}
create_delay_corner -name delay_corner_fft_slow \
    -library_set fft_slow \
    -rc_corner rc_corner
create_delay_corner -name delay_corner_fft_fast \
    -library_set fft_fast \
    -rc_corner rc_corner
create_constraint_mode -name functional_fft_slow \
    -sdc_files {/home/vlsitech_01/Cadence-RTL-to-GDSII-Flow-main/kasro/FFT/SYN/outputs/FFT_slow_sdc.sdc}
create_constraint_mode -name functional_fft_fast \
    -sdc_files {/home/vlsitech_01/Cadence-RTL-to-GDSII-Flow-main/kasro/FFT/SYN/outputs/FFT_fast_sdc.sdc}
create_analysis_view -name view_fft_slow \
    -constraint_mode functional_fft_slow \
    -delay_corner delay_corner_fft_slow
create_analysis_view -name view_fft_fast \
    -constraint_mode functional_fft_fast \
    -delay_corner delay_corner_fft_fast
set_analysis_view -setup {view_fft_slow} -hold {view_fft_fast}
setRouteMode -earlyGlobalMaxRouteLayer 5
setPinAssignMode -maxLayer 5
setNanoRouteMode -routeTopRoutingLayer 5
setDesignMode -topRoutingLayer Metal5
current_design
set_max_fanout 30 [current_design]
set_max_transition $MAX_TRANSITION_DATA -data_path [all_clocks]
set_max_transition $MAX_TRANSITION_CLOCK -clock_path [all_clocks]
setMultiCpuUsage -localCpu 1
setAnalysisMode -analysisType onChipVariation
setNanoRouteMode -routeWithTimingDriven true
setNanoRouteMode -quiet -routeInsertAntennaDiode true
set_propagated_clock [all_clocks]
route_opt_design
report_clocks
update_names -nocase
saveDesign FFT_DESIGN_LIBRARY/route_design.inn
report_power
checkDesign -all -outdir ./reports/route_design/checkDesign
checkDesign -all
optDesign -postRoute -drv -outDir ./reports/route_design/opt_1_drv
setOptMode -addInstancePrefix route_design_setup
optDesign -postRoute -incr -outDir ./reports/route_design/opt_2_setup
setOptMode -addInstancePrefix route_design_hold
setOptMode -holdFixingEffort high
setOptMode -setupTargetSlack 0.3
optDesign -postRoute -hold -outDir ./reports/route_design/opt_hold
set dbgLefDefOutVersion 5.8
set dbgDefOutLefVias 1
defOut -unit 1000 -floorplan -netlist ./def/route_design/FFT.def
saveNetlist ./ver/routed_design/FFT.v
saveDesign FFT_DESIGN_LIBRARY/route_design.inn
reportGateCount -outfile ./reports/route_design/FFT.sum
reportGateCount -outfile ./reports/route_design/reportGateCount.rpt
set_propagated_clock [all_clocks]
timeDesign -postRoute -timingDebugReport -hold -numPaths 100 -outDir ./reports/route_design
timeDesign -postRoute -timingDebugReport -prefix setup -numPaths 100 -outDir ./reports/route_design
timeDesign -reportOnly -numPaths 100 -outDir ./reports/route_design
summaryReport -outdir ./reports/route_design/summaryReport
report_ccopt_clock_trees -file ./reports/route_design/ccopt_clock_trees.rpt
report_ccopt_skew_groups -file ./reports/route_design/ccopt_skew_groups.rpt
reportCongestion -overflow
