#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Thu Dec 22 22:10:56 2022                
#                                                     
#######################################################

#@(#)CDS: Innovus v20.10-p004_1 (64bit) 05/07/2020 20:02 (Linux 2.6.32-431.11.2.el6.x86_64)
#@(#)CDS: NanoRoute 20.10-p004_1 NR200413-0234/20_10-UB (database version 18.20.505) {superthreading v1.69}
#@(#)CDS: AAE 20.10-p005 (64bit) 05/07/2020 (Linux 2.6.32-431.11.2.el6.x86_64)
#@(#)CDS: CTE 20.10-p005_1 () Apr 14 2020 09:14:28 ( )
#@(#)CDS: SYNTECH 20.10-b004_1 () Mar 12 2020 22:18:21 ( )
#@(#)CDS: CPE v20.10-p006
#@(#)CDS: IQuantus/TQuantus 19.1.3-s155 (64bit) Sun Nov 3 18:26:52 PST 2019 (Linux 2.6.32-431.11.2.el6.x86_64)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
win
set init_design_uniquify 1
set init_no_new_assigns 1
set ::TimeLib::tsgMarkCellLatchConstructFlag 1
set conf_qxconf_file NULL
set conf_qxlib_file NULL
set defHierChar /
set distributed_client_message_echo 1
set distributed_mmmc_disable_reports_auto_redirection 0
set eco_post_client_restore_command {update_timing ; write_eco_opt_db ;}
set enc_enable_print_mode_command_reset_options 1
set init_design_uniquify 1
set init_gnd_net GND
set init_lef_file {/usr/cad/CBDK/CBDK018_UMC_Faraday_v1.0/CIC/SOCE/lef/header6_V55_20ka_cic.lef /usr/cad/CBDK/CBDK018_UMC_Faraday_v1.0/CIC/SOCE/lef/fsa0m_a_generic_core.lef /usr/cad/CBDK/CBDK018_UMC_Faraday_v1.0/CIC/SOCE/lef/fsa0m_a_t33_generic_io.lef  ../sim/SRAM/SRAM.lef ../sim/data_array/data_array.lef ../sim/tag_array/tag_array.lef /usr/cad/CBDK/CBDK018_UMC_Faraday_v1.0/CIC/SOCE/lef/FSA0M_A_GENERIC_CORE_ANT_V55.lef}
set init_mmmc_file ../script/MMMC.view
set init_pwr_net VCC
set init_remove_assigns 1
set init_top_cell top
set init_verilog ../syn/top_syn.v
get_message -id GLOBAL-100 -suppress
get_message -id GLOBAL-100 -suppress
set latch_time_borrow_mode max_borrow
set pegDefaultResScaleFactor 1
set pegDetailResScaleFactor 1
get_message -id GLOBAL-100 -suppress
get_message -id GLOBAL-100 -suppress
set report_inactive_arcs_format {from to when arc_type sense reason}
set soft_stack_size_limit 192
set tso_post_client_restore_command {update_timing ; write_eco_opt_db ;}
init_design
zoomBox -2160.80200 -938.26900 4020.79000 4595.57500
zoomBox 79.15900 32.63500 3305.98900 2921.33700
zoomBox -352.52600 -154.47800 3443.74500 3243.99500
zoomBox -659.32500 -631.14300 3806.87700 3367.06100
saveIoFile -byOrder -temp ../pr/top.io
loadIoFile ../pr/top.io
