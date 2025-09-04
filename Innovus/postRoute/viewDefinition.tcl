if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name max_library_set\
   -timing\
    [list ${::IMEX::libVar}/mmmc/tcbn65gpluswc_ccs.lib]
create_library_set -name min_library_set\
   -timing\
    [list ${::IMEX::libVar}/mmmc/tcbn65gplusbc_ccs.lib]
create_timing_condition -name min_timing_condition\
   -library_sets [list min_library_set]
create_timing_condition -name max_timing_condition\
   -library_sets [list max_library_set]
create_rc_corner -name Default_RC_corner\
   -cap_table ${::IMEX::libVar}/mmmc/cln65g+_1p09m+alrdl_typical_top2.captable\
   -pre_route_res 1\
   -post_route_res {1 1 1}\
   -pre_route_cap 1\
   -post_route_cap {1 1 1}\
   -post_route_cross_cap {1 1 1}\
   -pre_route_clock_res 0\
   -pre_route_clock_cap 0\
   -qrc_tech ${::IMEX::libVar}/mmmc/Default_RC_corner/RC_IRCX_CRN65G+_1P9M+UT-ALRDL_6X1Z1U_typical.tch
create_delay_corner -name min_delay_corner\
   -timing_condition {min_timing_condition}\
   -rc_corner Default_RC_corner
create_delay_corner -name max_delay_corner\
   -timing_condition {max_timing_condition}\
   -rc_corner Default_RC_corner
create_constraint_mode -name counter_constraints\
   -sdc_files\
    [list /dev/null]
create_analysis_view -name best_case -constraint_mode counter_constraints -delay_corner min_delay_corner
create_analysis_view -name worst_case -constraint_mode counter_constraints -delay_corner max_delay_corner
set_analysis_view -setup [list worst_case] -hold [list best_case]
catch {set_interactive_constraint_mode [list counter_constraints] } 
