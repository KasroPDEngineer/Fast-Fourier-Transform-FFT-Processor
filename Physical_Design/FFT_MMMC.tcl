# === Library sets ===
create_library_set -name fft_slow -timing {/home/vlsitech_01/Cadence-RTL-to-GDSII-Flow-main/LIB/slow_vdd1v0_basiccells.lib}
create_library_set -name fft_fast -timing {/home/vlsitech_01/Cadence-RTL-to-GDSII-Flow-main/LIB/fast_vdd1v0_basicCells.lib}

# === RC corner ===
create_rc_corner -name rc_corner -cap_table {/home/vlsitech_01/Cadence-RTL-to-GDSII-Flow-main/Captable/cln28hpl_1p10m+alrdl_5x2yu2yz_typical.capTbl}

# === Delay corners (directly use library sets, no opcond/timing_condition) ===
create_delay_corner -name delay_corner_fft_slow \
    -library_set fft_slow \
    -rc_corner rc_corner

create_delay_corner -name delay_corner_fft_fast \
    -library_set fft_fast \
    -rc_corner rc_corner

# === Constraint modes ===
create_constraint_mode -name functional_fft_slow \
    -sdc_files {/home/vlsitech_01/Cadence-RTL-to-GDSII-Flow-main/kasro/FFT/SYN/outputs/FFT_slow_sdc.sdc}

create_constraint_mode -name functional_fft_fast \
    -sdc_files {/home/vlsitech_01/Cadence-RTL-to-GDSII-Flow-main/kasro/FFT/SYN/outputs/FFT_fast_sdc.sdc}

# === Analysis views ===
create_analysis_view -name view_fft_slow \
    -constraint_mode functional_fft_slow \
    -delay_corner delay_corner_fft_slow

create_analysis_view -name view_fft_fast \
    -constraint_mode functional_fft_fast \
    -delay_corner delay_corner_fft_fast

# === Setup / Hold assignment ===
set_analysis_view -setup {view_fft_slow} -hold {view_fft_fast}

