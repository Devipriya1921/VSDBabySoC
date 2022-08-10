set target_library [list /home/skandha/Tools_SNPS/Downloads_temp/SAED32_EDK/lib/stdcell_hvt/db_ccs/saed32hvt_tt0p85v25c.db   /home/devipriya/VSDBabySoC/src/module/avsdpll.db    /home/devipriya/VSDBabySoC/src/module/avsddac.db]
set link_library [list  /home/skandha/Tools_SNPS/Downloads_temp/SAED32_EDK/lib/stdcell_hvt/db_ccs/saed32hvt_tt0p85v25c.db    /home/devipriya/VSDBabySoC/src/module/avsdpll.db    /home/devipriya/VSDBabySoC/src/module/avsddac.db] 
set symbol_library ""

read_verilog /home/devipriya/VSDBabySoC/src/module/vsdbabysoc.v
read_verilog /home/devipriya/VSDBabySoC/src/module/rvmyth.v
read_verilog /home/devipriya/VSDBabySoC/src/module/clk_gate.v

read_lib -lib /home/devipriya/VSDBabySoC/src/module/avsdpll.lib
read_lib -lib  /home/devipriya/VSDBabySoC/src/module/avsddac.lib
analyze -library WORK -format verilog {/home/devipriya/VSDBabySoC/src/module/vsdbabysoc.v}
elaborate vsdbabysoc -architecture verilog -library WORK
analyze {}


create_clock -name "clk" -period 10 -waveform { 5 10 }
set_min_delay 0.01 -rise -to { vsdbabysoc } set_min_delay 0.01 -fall -to { vsdbabysoc }
set input_delay [ expr $clock_period / 4 ] set output_delay [ expr $clock_period / 4 ]
set_max_area 8000
set_max_fanout 8 vsdbabysoc
set_max_transition 5 vsdbabysoc

check_design

compile_ultra

file mkdir report
write -hierarchy -format verilog -output /home/devipriya/VSDBabySoC/src/module/report/vsdbabysoc_gtlvl.v
write_sdc -nosplit -version 2.0 /home/devipriya/VSDBabySoC/src/module/report/vsdbabysoc.sdc
report_area -hierarchy > /home/devipriya/VSDBabySoC/src/module/report/vsdbabysoc.area
report_timing > /home/devipriya/VSDBabySoC/src/module/report/vsdbabysoc.timing
report_power -hierarchy > /home/devipriya/VSDBabySoC/src/module/report/vsdbabysoc.power

gui_start
