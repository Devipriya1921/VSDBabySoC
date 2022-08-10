###################################################################

# Created by write_sdc on Thu Aug 11 01:05:32 2022

###################################################################
set sdc_version 2.0

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current uA
set_max_fanout 8 [current_design]
set_max_transition 5 [current_design]
set_max_area 8000
create_clock -name clk  -period 10  -waveform {5 10}
