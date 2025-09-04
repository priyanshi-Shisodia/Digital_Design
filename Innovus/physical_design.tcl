#DESIGN IMPORT

set design_mode 65
set init_design_netlisttype {verilog}

set init_pwr_net VDD
set init_gnd_net VSS

set floorplan_default_site CoreSite

read_mmmc /home/2022eeb1206/Desktop/Tsmc65nm_DDF_files/physical_design/TSMC65nm.view
read_physical -lef /home/2022eeb1206/Desktop/Tsmc65nm_DDF_files/lef/tcbn65gplus_200a/lef/tcbn65gplus_9lmT2.lef
read_netlist /home/2022eeb1206/Desktop/priyanshi/Genus/outputs/prbs_netlist.v

init_design
write_db ./Import_design/top_module.enc

#FLOORPLAN

set_io_flow_flag 0
create_floorplan -site core -core_density_size 1 0.4 3.6 3.6 3.6 3.6

#POWER PLAN

set_db add_rings_target default
set_db add_rings_extend_over_row 0
set_db add_rings_ignore_rows 0
set_db add_rings_avoid_short 0
set_db add_rings_skip_shared_inner_ring none
set_db add_rings_stacked_via_top_layer AP
set_db add_rings_stacked_via_bottom_layer M1
set_db add_rings_via_using_exact_crossover_size 1
set_db add_rings_orthogonal_only true
set_db add_rings_skip_via_on_pin {  standardcell }
set_db add_rings_skip_via_on_wire_shape {  noshape }
add_rings -nets {VDD VSS} -type core_rings -follow core -layer {top M9 bottom M9 left M8 right M8} -width {top 1 bottom 1 left 1 right 1} -spacing {top 0.8 bottom 0.8 left 0.8 right 0.8} -offset {top 0.8 bottom 0.8 left 0.8 right 0.8} -center 0 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid none

set_db add_stripes_ignore_block_check false
set_db add_stripes_break_at none
set_db add_stripes_route_over_rows_only false
set_db add_stripes_rows_without_stripes_only false
set_db add_stripes_extend_to_closest_target none
set_db add_stripes_stop_at_last_wire_for_area false
set_db add_stripes_partial_set_through_domain false
set_db add_stripes_ignore_non_default_domains false
set_db add_stripes_trim_antenna_back_to_shape none
set_db add_stripes_spacing_type edge_to_edge
set_db add_stripes_spacing_from_block 0
set_db add_stripes_stripe_min_length stripe_width
set_db add_stripes_stacked_via_top_layer AP
set_db add_stripes_stacked_via_bottom_layer M1
set_db add_stripes_via_using_exact_crossover_size false
set_db add_stripes_split_vias false
set_db add_stripes_orthogonal_only true
set_db add_stripes_allow_jog { padcore_ring  block_ring }
set_db add_stripes_skip_via_on_pin {  standardcell }
set_db add_stripes_skip_via_on_wire_shape {  noshape   }
add_stripes -nets {VDD VSS} -layer M8 -direction vertical -width 0.6 -spacing 0.6 -set_to_set_distance 8 -start_from left -start_offset 1 -stop_offset 0 -switch_layer_over_obs false -max_same_layer_jog_length 2 -pad_core_ring_top_layer_limit AP -pad_core_ring_bottom_layer_limit M1 -block_ring_top_layer_limit AP -block_ring_bottom_layer_limit M1 -use_wire_group 0 -snap_wire_center_to_grid none
write_floorplan top_module_final.fp

# CTS and ROUTING

connect_global_net VDD -type pg_pin -pin VDD -inst_base_name *
connect_global_net VSS -type pg_pin -pin VSS -inst_base_name *
set_db route_special_via_connect_to_shape { stripe }
route_special -connect core_pin -layer_change_range { M1(1) M9(9) } -block_pin_target nearest_target -core_pin_target first_after_row_end -allow_jogging 1 -crossover_via_layer_range { M1(1) M9(9) } -nets { VDD VSS } -allow_layer_change 1 -target_via_layer_range { M1(1) M9(9) }
place_opt_design
create_clock_tree_spec
ccopt_design
write_db postCTSopt
set_db route_design_with_timing_driven 1
set_db route_design_with_si_driven 1
set_db route_design_top_routing_layer 9
set_db route_design_bottom_routing_layer 1
set_db route_design_detail_end_iteration 1
set_db route_design_with_timing_driven true
set_db route_design_with_si_driven true
route_design -global_detail
