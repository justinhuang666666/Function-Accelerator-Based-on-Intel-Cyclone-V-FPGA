# TCL File Generated by Component Editor 18.1
# Mon Mar 20 20:46:59 GMT+08:00 2023
# DO NOT MODIFY


# 
# CUSTOM "CUSTOM" v1.0
#  2023.03.20.20:46:59
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module CUSTOM
# 
set_module_property DESCRIPTION ""
set_module_property NAME CUSTOM
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME CUSTOM
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL CUSTOM_INSTRUCTION
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file CORDIC_BASIC.v VERILOG PATH ip/CORDIC_BASIC.v
add_fileset_file CORDIC_Top.v VERILOG PATH ip/CORDIC_Top.v
add_fileset_file CUSTOM_INSTRUCTION.v VERILOG PATH ip/CUSTOM_INSTRUCTION.v TOP_LEVEL_FILE
add_fileset_file DOT_PRODUCT.v VERILOG PATH ip/DOT_PRODUCT.v
add_fileset_file Fix2Floating.v VERILOG PATH ip/Fix2Floating.v
add_fileset_file Floating2Fix.v VERILOG PATH ip/Floating2Fix.v
add_fileset_file Inside_COS.v VERILOG PATH ip/Inside_COS.v
add_fileset_file MOD_FP_ADD.v VERILOG PATH ip/MOD_FP_ADD.v
add_fileset_file MOD_FP_MULT.v VERILOG PATH ip/MOD_FP_MULT.v
add_fileset_file PE.v VERILOG PATH ip/PE.v


# 
# parameters
# 
add_parameter IDLE STD_LOGIC_VECTOR 0
set_parameter_property IDLE DEFAULT_VALUE 0
set_parameter_property IDLE DISPLAY_NAME IDLE
set_parameter_property IDLE WIDTH 3
set_parameter_property IDLE TYPE STD_LOGIC_VECTOR
set_parameter_property IDLE UNITS None
set_parameter_property IDLE ALLOWED_RANGES 0:7
set_parameter_property IDLE HDL_PARAMETER true
add_parameter PROCESS STD_LOGIC_VECTOR 1
set_parameter_property PROCESS DEFAULT_VALUE 1
set_parameter_property PROCESS DISPLAY_NAME PROCESS
set_parameter_property PROCESS WIDTH 3
set_parameter_property PROCESS TYPE STD_LOGIC_VECTOR
set_parameter_property PROCESS UNITS None
set_parameter_property PROCESS ALLOWED_RANGES 0:7
set_parameter_property PROCESS HDL_PARAMETER true
add_parameter FINISH STD_LOGIC_VECTOR 2
set_parameter_property FINISH DEFAULT_VALUE 2
set_parameter_property FINISH DISPLAY_NAME FINISH
set_parameter_property FINISH WIDTH 3
set_parameter_property FINISH TYPE STD_LOGIC_VECTOR
set_parameter_property FINISH UNITS None
set_parameter_property FINISH ALLOWED_RANGES 0:7
set_parameter_property FINISH HDL_PARAMETER true
add_parameter CYCLE_DELAY STD_LOGIC_VECTOR 74
set_parameter_property CYCLE_DELAY DEFAULT_VALUE 74
set_parameter_property CYCLE_DELAY DISPLAY_NAME CYCLE_DELAY
set_parameter_property CYCLE_DELAY WIDTH 8
set_parameter_property CYCLE_DELAY TYPE STD_LOGIC_VECTOR
set_parameter_property CYCLE_DELAY UNITS None
set_parameter_property CYCLE_DELAY ALLOWED_RANGES 0:255
set_parameter_property CYCLE_DELAY HDL_PARAMETER true
add_parameter INIT_BOUND1 STD_LOGIC_VECTOR 2
set_parameter_property INIT_BOUND1 DEFAULT_VALUE 2
set_parameter_property INIT_BOUND1 DISPLAY_NAME INIT_BOUND1
set_parameter_property INIT_BOUND1 WIDTH 7
set_parameter_property INIT_BOUND1 TYPE STD_LOGIC_VECTOR
set_parameter_property INIT_BOUND1 UNITS None
set_parameter_property INIT_BOUND1 ALLOWED_RANGES 0:127
set_parameter_property INIT_BOUND1 HDL_PARAMETER true
add_parameter INIT_BOUND2 STD_LOGIC_VECTOR 5
set_parameter_property INIT_BOUND2 DEFAULT_VALUE 5
set_parameter_property INIT_BOUND2 DISPLAY_NAME INIT_BOUND2
set_parameter_property INIT_BOUND2 WIDTH 7
set_parameter_property INIT_BOUND2 TYPE STD_LOGIC_VECTOR
set_parameter_property INIT_BOUND2 UNITS None
set_parameter_property INIT_BOUND2 ALLOWED_RANGES 0:127
set_parameter_property INIT_BOUND2 HDL_PARAMETER true


# 
# display items
# 


# 
# connection point nios_custom_instruction_slave
# 
add_interface nios_custom_instruction_slave nios_custom_instruction end
set_interface_property nios_custom_instruction_slave clockCycle 0
set_interface_property nios_custom_instruction_slave operands 2
set_interface_property nios_custom_instruction_slave ENABLED true
set_interface_property nios_custom_instruction_slave EXPORT_OF ""
set_interface_property nios_custom_instruction_slave PORT_NAME_MAP ""
set_interface_property nios_custom_instruction_slave CMSIS_SVD_VARIABLES ""
set_interface_property nios_custom_instruction_slave SVD_ADDRESS_GROUP ""

add_interface_port nios_custom_instruction_slave clk_en clk_en Input 1
add_interface_port nios_custom_instruction_slave aclr reset Input 1
add_interface_port nios_custom_instruction_slave start start Input 1
add_interface_port nios_custom_instruction_slave N n Input 8
add_interface_port nios_custom_instruction_slave dataa dataa Input 32
add_interface_port nios_custom_instruction_slave datab datab Input 32
add_interface_port nios_custom_instruction_slave done done Output 1
add_interface_port nios_custom_instruction_slave result result Output 32
add_interface_port nios_custom_instruction_slave clk clk Input 1

