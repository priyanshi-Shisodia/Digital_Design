create_clock -name clk -period 10 -waveform {0 5} [get_ports "clk"]
set_propagated_clock [get_clocks "clk"]

set_clock_transition -rise 0.1 [get_clocks "clk"]
set_clock_transition -fall 0.1 [get_clocks "clk"]

set_clock_uncertainty 0.01 [get_clocks "clk"]

set_input_delay -max 1.0 [get_ports {"switch[0]" "switch[1]" "switch[2]" "switch[3]"}] -clock [get_clocks "clk"]
set_input_delay -min 0.3 [get_ports {"switch[0]" "switch[1]" "switch[2]" "switch[3]"}] -clock [get_clocks "clk"] 

set_input_delay -max 1.0 [get_ports {"sel[1]" "sel[2]" "sel[3]"}] -clock [get_clocks "clk"]
set_input_delay -min 0.3 [get_ports {"sel[1]" "sel[2]" "sel[3]"}] -clock [get_clocks "clk"]

set_input_delay -max 1.0 [get_ports "sel_initial"] -clock [get_clocks "clk"]
set_input_delay -min 0.3 [get_ports "sel_initial"] -clock [get_clocks "clk"]

set_output_delay -max 1.0 [get_ports "out"] -clock [get_clocks "clk"]
set_output_delay -min 0.2 [get_ports "out"] -clock [get_clocks "clk"]