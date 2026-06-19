#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Wed Oct  8 16:40:33 2025                
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
setUIVar rda_Input ui_settop 1
setUIVar rda_Input ui_topcell FFT
setUIVar rda_Input ui_netlist /home/vlsitech_01/Cadence-RTL-to-GDSII-Flow-main/kasro/FFT/SYN/outputs/FFT_netlist.v
setUIVar rda_Input ui_timelib,max /home/vlsitech_01/Cadence-RTL-to-GDSII-Flow-main/LIB/slow_vdd1v0_basiccells.lib
setUIVar rda_Input ui_timelib,min /home/vlsitech_01/Cadence-RTL-to-GDSII-Flow-main/LIB/fast_vdd1v0_basicCells.lib
setUIVar rda_Input ui_leffile {/home/vlsitech_01/Cadence-RTL-to-GDSII-Flow-main/LEF/gsclib045_tech.lef /home/vlsitech_01/Cadence-RTL-to-GDSII-Flow-main/LEF/gsclib045_macro.lef}
setUIVar rda_Input ui_timingcon_file /home/vlsitech_01/Cadence-RTL-to-GDSII-Flow-main/kasro/FFT/SYN/outputs/FFT_sdc.sdc
setUIVar rda_Input ui_delay_limit 1000
setUIVar rda_Input ui_net_delay 1000.0ps
setUIVar rda_Input ui_net_load 0.5pf
setUIVar rda_Input ui_in_tran_delay 0.1ps
setUIVar rda_Input ui_rel_c_thresh 0.03
setUIVar rda_Input ui_tot_c_thresh 5.0
setUIVar rda_Input ui_pwrnet VDD
setUIVar rda_Input ui_gndnet VSS
setUIVar rda_Input flip_first 1
init_design
defIn /home/vlsitech_01/Cadence-RTL-to-GDSII-Flow-main/kasro/FFT/Physical_Design/FFT.floorplan.def
checkPinAssignment
deselectAll
setPtnPinStatus -cell FFT -pin * -status fixed
redirect ./reports/init_design/report_report_analysis_views report_analysis_views
remove_assigns
remove_assigns -buffering -ignorePortConstraints
update_names -nocase
saveDesign FFT_DESIGN_LIBRARY/init_design.inn
checkDesign -all -outdir reports/init_design
setCheckMode -tapeOut true
setCheckMode -all true
summaryReport -outdir reports/init_design/summaryReport
redirect ./reports/init_design/init_design.report_report_tracks {report_tracks -prefer_only} -tee
verify_drc -limit 1000000 -report reports/init_design/report_verify_drc
