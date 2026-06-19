#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Wed Oct  8 16:45:37 2025                
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
restoreDesign FFT_DESIGN_LIBRARY/init_design.inn.dat FFT
all_constraint_modes -active
set_interactive_constraint_modes [all_constraint_modes -active]
current_design
set_max_capacitance $MAX_CAP [current_design]
set_propagated_clock [all_clocks]
set_max_transition $MAX_TRANSITION_DATA -data_path [all_clocks]
set_max_transition $MAX_TRANSITION_CLOCK -clock_path [all_clocks]
reset_clock_uncertainty -from [all_clocks] -to [all_clocks]
set_clock_uncertainty -setup $SETUP_CLOCK_UNCERTAINTY [all_clocks]
set_clock_uncertainty -hold $HOLD_CLOCK_UNCERTAINTY [all_clocks]
update_constraint_mode -name functional_fft_slow -sdc_files $FUNC_SDC
setDesignMode -topRoutingLayer 5
current_design
set_max_fanout 20 [current_design]
setDesignMode -process 45
setMultiCpuUsage -keepLicense true
setMultiCpuUsage -localCpu 16
setRouteMode -earlyGlobalMaxRouteLayer 5
setPinAssignMode -maxLayer 5
setNanoRouteMode -routeTopRoutingLayer 5
setDesignMode -topRoutingLayer Metal5
delete_ccopt_clock_tree_spec
create_ccopt_clock_tree_spec -file data/ccopt.ctstch
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
set_global report_timing_format {hpin net arc cell fanout load slew delay arrival}
setAnalysisMode -timeBorrowing false
setAnalysisMode -analysisType onChipVariation
setAnalysisMode -cppr both
setPlaceMode -placeIoPins false
setPlaceMode -clkGateAware true
setPlaceMode -softGuide true
setPlaceMode -maxDensity 0.90
setPlaceMode -ignoreScan 1
setPlaceMode -moduleAwareSpare false
setPlaceMode -ignoreSpare true
setOptMode -maxLength 400
setOptMode -simplifyNetlist false
setOptMode -fixFanoutLoad true
setOptMode -fixGlitch true
setOptMode -usefulSkew false
setPlaceMode -place_global_ignore_scan true
setPlaceMode -place_global_reorder_scan true
setPlaceMode -place_global_clock_gate_aware true
setPlaceMode -place_global_uniform_density true
setPlaceMode -place_global_cong_effort high
setPlaceMode -place_opt_run_global_place full
setLimitedAccessFeature legacy_fects_final_release 1
group_path -name "reg2reg" -from [all_registers] -to [filter_collection [all_registers] "is_integrated_clock_gating_cell != true"]
group_path -name "clkgate" -from [all_registers] -to [filter_collection [all_registers] "is_integrated_clock_gating_cell == true"]
group_path -name in2reg -from [all_inputs -no_clocks] -to [all_registers]
group_path -name reg2out -from [all_registers] -to [all_outputs]
group_path -name in2out -from [all_inputs -no_clocks] -to [all_outputs]
setPathGroupOptions reg2reg -effortLevel high
setPathGroupOptions in2reg -effortLevel high
setPathGroupOptions reg2out -effortLevel high
setPathGroupOptions in2out -effortLevel high
setPathGroupOptions clkgate -slackAdjustment 0
setPathGroupOptions in2reg -slackAdjustment 0
setPathGroupOptions reg2out -slackAdjustment 0
set_max_delay 14 -from [all_registers -clock_pins] -to [all_outputs]
redirect ./reports/place_opt/report_analysis_views.rpt report_analysis_views
report_tracks -prefer_only
setOptMode -usefulSkewPreCTS false
place_opt_design
update_names -nocase
saveDesign FFT_DESIGN_LIBRARY/placeinit.inn
saveDesign FFT_DESIGN_LIBRARY/place_opt.inn
timeDesign -reportOnly -numPaths 10000 -outDir ./reports/place_opt/reg2reg_wo
timeDesign -reportOnly -numPaths 10000 -hold -outDir ./reports/place_opt/reg2reg_wo
reportGateCount -outfile ./reports/place_opt/reg2reg_wo/report_gate_count.sum
saveDesign FFT_DESIGN_LIBRARY/place_opt_after_scanReorder.inn
report_clocks
group_path -name "reg2reg" -from [all_registers] -to [filter_collection [all_registers] "is_integrated_clock_gating_cell != true"]
group_path -name "clkgate" -from [all_registers] -to [filter_collection [all_registers] "is_integrated_clock_gating_cell == true"]
group_path -name in2reg -from [all_inputs -no_clocks] -to [all_registers]
group_path -name reg2out -from [all_registers] -to [all_outputs]
group_path -name in2out -from [all_inputs -no_clocks] -to [all_outputs]
setPathGroupOptions reg2reg -effortLevel high
setPathGroupOptions clkgate -slackAdjustment 0
setPathGroupOptions in2reg -slackAdjustment 0
setPathGroupOptions reg2out -slackAdjustment 0
reportPathGroupOptions
setOptMode -addInstancePrefix pre_cts
setOptMode -fixFanoutLoad true
optDesign -preCTS -drv -outDir ./reports/place_opt/reg2reg_drv
set dbgLefDefOutVersion 5.8
set dbgDefOutLefVias 1
defOut -unit 1000 -floorplan -netlist ./def/placed/FFT.def
saveNetlist ./ver/placed/FFT.v
reportGateCount -outfile ./reports/place_opt/FFT.sum
reportCongestion -overflow -hotSpot -3d -num_hotspot 20
checkPlace ./reports/place_opt/report_checkPlace
report_power
checkDesign -all
redirect {puts "corner_coordinates\n[dbGet top.fPlan.boxes]"} > reports/fPlan.rpt
redirect {puts "no_of_rows= [dbGet top.fPlan.numRows]"} >> reports/fPlan.rpt
redirect {puts "row_height= [dbGet top.fPlan.coreSite.size_y]"} >> reports/fPlan.rpt
redirect {puts "design_height= [dbGet top.fPlan.box_sizey]"} >> reports/fPlan.rpt
summaryReport -outdir ./reports/place_opt/summaryReport
report_constraint -drv_violation_type max_capacitance > reports/place_opt/FFT_max_cap.rpt
report_constraint -drv_violation_type max_transition > reports/place_opt/FFT_max_tran.rpt
report_constraint -drv_violation_type max_fanout > reports/place_opt/FFT_max_fanout.rpt
