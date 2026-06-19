#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Wed Oct  8 16:59:35 2025                
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
restoreDesign FFT_DESIGN_LIBRARY/place_opt.inn.dat FFT
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
set_max_transition $MAX_TRANSITION_DATA -data_path [all_clocks]
set_max_transition $MAX_TRANSITION_CLOCK -clock_path [all_clocks]
set_max_delay 14 -from [all_registers -clock_pins] -to [all_outputs]
setRouteMode -earlyGlobalMaxRouteLayer 5
setPinAssignMode -maxLayer 5
setNanoRouteMode -routeTopRoutingLayer 5
setDesignMode -topRoutingLayer Metal5
current_design
set_max_fanout $MAX_FANOUT [current_design]
setMultiCpuUsage -localCpu 4
setvar soceSupportRiseFallPinCap 1
setAnalysisMode -timeBorrowing false
setAnalysisMode -analysisType onChipVariation
setAnalysisMode -cppr both
delete_ccopt_clock_tree_spec
get_ccopt_clock_trees
ccopt_check_and_flatten_ilms_no_restore
set_ccopt_property cts_is_sdc_clock_root -pin clk true
create_ccopt_clock_tree -name clk -source clk -no_skew_group
set_ccopt_property target_max_trans_sdc -delay_corner delay_corner_fft_slow -early -clock_tree clk 0.100
set_ccopt_property target_max_trans_sdc -delay_corner delay_corner_fft_slow -late -clock_tree clk 0.100
set_ccopt_property clock_period -pin clk 8
set_ccopt_property timing_connectivity_info {}
create_ccopt_skew_group -name clk/functional_fft_slow -sources clk -auto_sinks
set_ccopt_property include_source_latency -skew_group clk/functional_fft_slow true
set_ccopt_property extracted_from_clock_name -skew_group clk/functional_fft_slow clk
set_ccopt_property extracted_from_constraint_mode_names -skew_group clk/functional_fft_slow {functional_fft_slow  }
set_ccopt_property extracted_from_delay_corners -skew_group clk/functional_fft_slow delay_corner_fft_slow
create_ccopt_skew_group -name clk/functional_fft_fast -sources clk -auto_sinks
set_ccopt_property include_source_latency -skew_group clk/functional_fft_fast true
set_ccopt_property extracted_from_clock_name -skew_group clk/functional_fft_fast clk
set_ccopt_property extracted_from_constraint_mode_names -skew_group clk/functional_fft_fast {functional_fft_fast  }
set_ccopt_property extracted_from_delay_corners -skew_group clk/functional_fft_fast delay_corner_fft_fast
check_ccopt_clock_tree_convergence
get_ccopt_property auto_design_state_for_ilms
set_ccopt_property buffer_cells {}
set_ccopt_property inverter_cells {}
set_ccopt_property force_nanoroute_single_threaded false
set_ccopt_property target_max_trans 0.6 -net_type leaf
set_ccopt_property target_max_trans 0.6 -net_type trunk
set_ccopt_property target_max_trans 0.6 -net_type top
set_ccopt_property target_skew 0.250
set_ccopt_property -use_inverters false
set_ccopt_property target_insertion_delay 2
set_ccopt_property source_max_capacitance 2.00
setOptMode -simplifyNetlist false
set_ccopt_property -delay_corner * target_skew -late 0.500
set_ccopt_property -delay_corner * target_skew -early 0.500
set_ccopt_property cts_target_skew 0.250
set_ccopt_property advanced_insertion_delay_optimization true
set_ccopt_property expand_multi_child_regions true
set_ccopt_property low_power_clustering false
set_ccopt_property recluster_to_reduce_power true
set_ccopt_property max_fanout 20
setOptMode -maxLength 500
setOptMode -addInstancePrefix cts
setOptMode -usefulSkew false
set_ccopt_property call_cong_repair_during_final_implementation true
set_ccopt_property add_wire_delay_in_detailed_balancer true
set_ccopt_property fraction_max_wire_to_add 0.5
redirect ./reports/clock_opt/report_report_analysis_views report_analysis_views
ccopt_design
report_ccopt_skew_groups -summary -file ./reports/clock_opt/skew.rep
report_ccopt_clock_trees -summary -file ./reports/clock_opt/tree.rep
report_ccopt_clock_trees -file reports/clock_opt/ccopt_clock_trees.rpt
report_ccopt_skew_groups -file ./reports/clock_opt/ccopt_skew_groups.rpt
report_clocks
update_names -nocase
saveDesign FFT_DESIGN_LIBRARY/clock_opt.inn
reportGateCount -outfile ./reports/clock_opt/FFT.sum
set_propagated_clock [all_clocks]
timeDesign -postCTS -hold -timingDebugReport -numPaths 100 -outDir ./reports/clock_opt
timeDesign -reportOnly -numPaths 100 -outDir ./reports/clock_opt
timeDesign -reportOnly -timingDebugReport -prefix setup -numPaths 100 -outDir ./reports/clock_opt
setDelayCalMode -engine AAE -signOff true
setExtractRCMode -engine postRoute -specialNet true
timeDesign -reportOnly -timingDebugReport -prefix setupAAE -numPaths 100 -outDir ./reports/clock_opt
report_power
report_tracks -prefer_only
checkDesign -all
summaryReport -outdir ./reports/clock_opt/summaryReport
