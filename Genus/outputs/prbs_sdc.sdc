# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.14-s082_1 on Sat Apr 05 14:59:31 IST 2025

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design top_module

create_clock -name "clk" -period 10.0 -waveform {0.0 5.0} [get_ports clk]
set_clock_transition 0.1 [get_clocks clk]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {switch[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {switch[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {switch[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {switch[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.3 [get_ports {switch[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.3 [get_ports {switch[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.3 [get_ports {switch[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.3 [get_ports {switch[0]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {sel[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {sel[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports {sel[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.3 [get_ports {sel[3]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.3 [get_ports {sel[2]}]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.3 [get_ports {sel[1]}]
set_input_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports sel_initial]
set_input_delay -clock [get_clocks clk] -add_delay -min 0.3 [get_ports sel_initial]
set_output_delay -clock [get_clocks clk] -add_delay -max 1.0 [get_ports out]
set_output_delay -clock [get_clocks clk] -add_delay -min 0.2 [get_ports out]
set_wire_load_mode "segmented"
set_clock_uncertainty -setup 0.01 [get_clocks clk]
set_clock_uncertainty -hold 0.01 [get_clocks clk]
## List of unsupported SDC commands ##
set_propagated_clock [get_clocks "clk"]
