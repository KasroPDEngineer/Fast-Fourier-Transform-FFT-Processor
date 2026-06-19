BLOCK = FFT 

DATE = $(date +"%Y%m%d%H%M")

## Work directories
REPORT_DIR	= reports
LOG		= log
LOG_INVS	= log_invs
LSF		= 
SYN_EXEC	= genus
FE_EXEC		= innovus  
OPTIONS		= -nowin -overwrite -64 
WOPTIONS	= -overwrite -64 

#########################################################################################
#	Makefile Targets								#
#########################################################################################

## Default targets

default:
	@echo "Usage: make <target>"
	@echo "syn_design (run synthesis to generate netlist)"
	@echo "		   init_design	(Depen.inny. check_setup)"
	@echo "		   place_opt	(Depen.inny: init_design)"
	@echo "		   clock_opt	(Depen.inny: place_opt)"
	@echo "		   route_design (Depen.inny: clock_opt)"
	@echo "		   post_route	(Depen.inny: route_design)"
syn_design:
	@echo ""
	@echo "#### Start syn_design at `date '+%D %T'` ####"
	@mkdir -p $(Report_DIR) $(LOG)
	$(LSF) $(SYN_EXEC) $(WOPTIONS) -files scripts/syn_design.tcl -log $(LOG)/syn_design.log | tee $(LOG)/syn_design.log_${DATE}
	@touch syn_design
	@echo "#### End synthesis at date `date '+%D %T'` ####"
init_design: syn_design 
	@echo ""
	@echo "#### Start init_design at `date '+%D %T'`  ####"
	@mkdir -p $(REPORT_DIR) $(LOG) 
	$(LSF) $(FE_EXEC) $(WOPTIONS) -init scripts/init_design.tcl -log $(LOG)/init_design.log | tee $(LOG)/init_design.log_${DATE}
	@touch init_design
	@echo "#### End init_design at `date '+%D %T'`	####"

place_opt: init_design
	@ls init_design
	@rm -rf  ver/placed def/placed junk
	@echo ""
	@echo "#### Start place_opt at `date '+%D %T'`	####"
	@mkdir -p $(REPORT_DIR) $(LOG) ver/placed def/placed
	$(LSF) $(FE_EXEC) $(WOPTIONS) -init scripts/place_opt.tcl -log $(LOG)/place_opt.log | tee $(LOG)/place_opt.log_${DATE}
	@touch place_opt
	@echo "#### End place_opt at `date '+%D %T'`  ####"

clock_opt: place_opt
	@ls place_opt
	@mkdir junk
	@rm -rf ver/postCTS def/postCTS junk
	@mkdir -p $(REPORT_DIR) $(LOG) 
	@mkdir -p $(REPORT_DIR) $(LOG) ver/postCTS def/postCTS
	@echo ""
	@echo "#### Start clock_opt at `date '+%D %T'`	####"
	$(LSF) $(FE_EXEC) $(WOPTIONS) -init scripts/clock_opt.tcl -log $(LOG)/clock_opt.log | tee $(LOG)/clock_opt.log_${DATE}
	@./scripts/gen_runTime.csh clock_opt
	@touch clock_opt
	@echo "#### End clock_opt at `date '+%D %T'`  ####"

route_design: clock_opt
	@ls clock_opt
	@/bin/rm -rf  ver/routed def/routed ver/route_design def/route_design junk
	@mkdir -p $(REPORT_DIR) $(LOG) ver/route_design def/route_design
	@echo ""
	@echo "#### Start route_design at `date '+%D %T'`	####"
	@mkdir -p $(REPORT_DIR) $(LOG) 
	$(LSF) $(FE_EXEC) $(OPTIONS) -init scripts/route_design.tcl -log $(LOG)/route_design.log | tee $(LOG)/route_design.log_${DATE}
	@./scripts/gen_runTime.csh route_design
	@touch route_design 
	@echo "#### End route_design at `date '+%D %T'`  ####"

