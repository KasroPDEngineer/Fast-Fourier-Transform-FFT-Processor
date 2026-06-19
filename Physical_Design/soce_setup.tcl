puts "RM-info: Starting script.. [info script]"

set DESIGN_NAME                 "FFT"        ;# The name of the top-level design.  
set LIB_USED                    "9trk"                  ;# set to either "9trk" or "12trk", default is 12trk 
set DESIGN_FLOW                 "asic"                  ;# select flow used; either "asic | semicustom"
set PROCESS_NODE                "45"                    ;# value of the process node. e.g- 180, 90 etc
set CTS_ENGINE                  "CCOPT"                 ;# select either "CCOPT" or "FECTS"

#######################################################################################
# Design Input                                                                         #
########################################################################################

set INIT_DESIGN_INPUT           "/home/vlsitech_01/Cadence-RTL-to-GDSII-Flow-main/Test/RTL/FFT.v"                       ;# verilog - starting point
set VERILOG_NETLIST_FILE        "/home/vlsitech_01/Cadence-RTL-to-GDSII-Flow-main/kasro/FFT/SYN/outputs/FFT_netlist.v"  ;# Input gate verilog
set SDC_FILE                    "/home/vlsitech_01/Cadence-RTL-to-GDSII-Flow-main/kasro/FFT/SYN/outputs/FFT_sdc.sdc" ;# timing constraints
set FUNC_SDC                    "/home/vlsitech_01/Cadence-RTL-to-GDSII-Flow-main/kasro/FFT/SYN/outputs/FFT_sdc.sdc" ;# timing constraints
set INIT_MMMC_FILE              "/home/vlsitech_01/Cadence-RTL-to-GDSII-Flow-main/kasro/FFT/Physical_Design/FFT_MMMC.tcl";# timing constraints
set DEF_FILE                    "/home/vlsitech_01/Cadence-RTL-to-GDSII-Flow-main/kasro/FFT/Physical_Design/FFT.floorplan.def";#floorplanDEF format
set DEF_IO_PIN                  "" ;# def file for pin location
set SCAN_CLKSDC_FILE            "" ;# timing constraints
set SCAN_DEF_FILE               ""
set FLOORPLAN_FILE              ""                              ;# Floorplan in Encounter fp format; Not tested yet
set TCL_FILE                    ""                              ;# floorplan data in Tcl format, plus other custom data
set IO_FILE                     ""                              ;# I/O pins file for default floorplan; If no DEF_FILE 
set CREATE_PWRGRID              0                               ;# to draw pwrgrid in SOCE for asic blocks 
set LOAD_INITIAL_ID_TCL_FILE    0
set LOAD_FINAL_ID_TCL_FILE      0
set ADD_TAPCELL                 1
set TAP_DISTANGE                60
set ADD_SPARE                   1                               ;# 1 if spare is required, 0 if not required
set ADD_BOUNDARY_CELL           0
set POWERNET_NAME		VDD
set GROUNDNET_NAME		VSS
# Output paths
set RC_CORN                     "(rcworst)"
set RC_CORN_STA                 "(rcbest rcworst)"
set REPORTS_DIR                 "reports"                       ;# Directory to write reports.
set LOG_DIR                     "log"                           ;# Directory to write output data files

set TARGET_LIBRARY_FILES        "/home/vlsitech_01/Cadence-RTL-to-GDSII-Flow-main/LIB/slow_vdd1v0_basiccells.lib"
set MIN_LIBRARY_FILES           "/home/vlsitech_01/Cadence-RTL-to-GDSII-Flow-main/LIB/fast_vdd1v0_basicCells.lib"
set LIBRARY_LEF_FILES           "/home/vlsitech_01/Cadence-RTL-to-GDSII-Flow-main/LEF/gsclib045_tech.lef /home/vlsitech_01/Cadence-RTL-to-GDSII-Flow-main/LEF/gsclib045_macro.lef" 

set CAP_TABLE_MAX_FILE          ""
set CAP_TABLE_MIN_FILE          ""
set CAP_TABLE_TYP_FILE          "/home/vlsitech_01/Cadence-RTL-to-GDSII-Flow-main/Captable/cln28hpl_1p10m+alrdl_5x2yu2yz_typical.capTbl
"

set QRC_TECH_FILE_MAX           ""
set QRC_TECH_FILE_MIN           ""
set QRC_TECH_FILE_TYPICAL       ""

set ASPECT_RATIO                1               ;# Use values between 0.5 and 2. This determines the shape of the floorplan
set CORE_UTILIZATION            0.7             ;# Use values between 0.5 and 0.7 This determines the size of the floorplan.
set IO_FILE                     ""      ;# IO pins constraints in Cadence io-file format

set MIN_ROUTING_LAYER           "1"
set MAX_ROUTING_LAYER           "5"

set GDS2MAP     ""
set GDS_FILES   ""

setDesignMode -process $PROCESS_NODE

set FILLER_CELLS {}


set MAX_TRANSITION_DATA         1.5      ;#from sdc
set MAX_TRANSITION_CLOCK        0.75     ;#from sdc
set MAX_FANOUT                  20       ;# TODO: Need Trial and Error process to find out the True value. 
set MAX_CAP                     0.1      ;#The suggestion was to use 100fF = 0.1pF
set SOURCE_MAXCAP               2.00     ;#Found in the CTS file
set TARGET_SKEW                 0.250    ;# Set Skew Target
set MAX_WIRELENGTH              500      ;#Arm guideline is to use <800um, We are choosing 500  
set SETUP_CLOCK_UNCERTAINTY     0.5      ;#Update it after every SDC update.
set HOLD_CLOCK_UNCERTAINTY      0.07
set CTS_TOP_ROUTING_LAYER       5
set CTS_BOTTOM_ROUTING_LAYER    1

set IS_SCAN_AVAILABLE           1               ;# 1 if scan is included in the RTL and SCANDEF is available

set IS_NETLIST_ECO              "0"
set ECO_DESIGN_DIR              ""
set ECO_NETLIST                 ""
set FFT_DESIGN_LIBRARY          "FFT_DESIGN_LIBRARY"
puts "RM-info: Completed script..[info script]"
