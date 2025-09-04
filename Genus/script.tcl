set_db init_lib_search_path /home/2022eeb1206/Desktop/Tsmc65nm_DDF_files/LIB/
set_db init_hdl_search_path /home/2022eeb1206/Desktop/priyanshi/xcelium/

read_libs /home/2022eeb1206/Desktop/Tsmc65nm_DDF_files/LIB/tcbn65gpluswc_ccs.lib
read_hdl /home/2022eeb1206/Desktop/priyanshi/xcelium/vcode.v
elaborate

read_sdc /home/2022eeb1206/Desktop/priyanshi/constraints/constraints_top.sdc

set_db syn_generic_effort medium
set_db syn_map_effort medium
set_db syn_opt_effort medium

syn_generic
syn_map
syn_opt

#reports
report_timing > reports/report_timing.rpt
report_power  > reports/report_power.rpt
report_area   > reports/report_area.rpt
report_qor    > reports/report_qor.rpt

#outputs
write_hdl > outputs/prbs_netlist.v
write_sdc > outputs/prbs_sdc.sdc
write_sdf -timescale ns -nonegchecks -recrem split -edges check_edge -setuphold split > outputs/delays.sdf