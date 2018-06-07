# 
# Synthesis run script generated by Vivado
# 

namespace eval rt {
    variable rc
}
set rt::rc [catch {
  uplevel #0 {
    set ::env(BUILTIN_SYNTH) true
    source $::env(HRT_TCL_PATH)/rtSynthPrep.tcl
    set rt::cmdEcho 0
    rt::set_parameter writeXmsg true
    set ::env(RT_TMP) "./.Xil/Vivado-14852-LAPTOP-0H77ONJ6/realtime/tmp"
    if { [ info exists ::env(RT_TMP) ] } {
      file delete -force $::env(RT_TMP)
      file mkdir $::env(RT_TMP)
    }

    rt::delete_design

    set rt::partid xc7a35tcpg236-1

    source $::env(SYNTH_COMMON)/common.tcl
    set rt::defaultWorkLibName xil_defaultlib

    set rt::useElabCache false
    if {$rt::useElabCache == false} {
      rt::read_verilog {
      H:/Vivado/VivadoProject/SingleCPU/SingleCPU.srcs/sources_1/new/SignZeroExtend.v
      H:/Vivado/VivadoProject/SingleCPU/SingleCPU.srcs/sources_1/new/RegisterFile.v
      H:/Vivado/VivadoProject/SingleCPU/SingleCPU.srcs/sources_1/new/PCPlus4.v
      H:/Vivado/VivadoProject/SingleCPU/SingleCPU.srcs/sources_1/new/PC.v
      H:/Vivado/VivadoProject/SingleCPU/SingleCPU.srcs/sources_1/new/Multiplexer4_32.v
      H:/Vivado/VivadoProject/SingleCPU/SingleCPU.srcs/sources_1/new/Multiplexer2_5.v
      H:/Vivado/VivadoProject/SingleCPU/SingleCPU.srcs/sources_1/new/Multiplexer2_32_5.v
      H:/Vivado/VivadoProject/SingleCPU/SingleCPU.srcs/sources_1/new/Multiplexer2_32.v
      H:/Vivado/VivadoProject/SingleCPU/SingleCPU.srcs/sources_1/new/J_Address.v
      H:/Vivado/VivadoProject/SingleCPU/SingleCPU.srcs/sources_1/new/InstructMemory.v
      H:/Vivado/VivadoProject/SingleCPU/SingleCPU.srcs/sources_1/new/DataMemory.v
      H:/Vivado/VivadoProject/SingleCPU/SingleCPU.srcs/sources_1/new/ControlUnit.v
      H:/Vivado/VivadoProject/SingleCPU/SingleCPU.srcs/sources_1/new/BranchPlus.v
      H:/Vivado/VivadoProject/SingleCPU/SingleCPU.srcs/sources_1/new/ALU.v
      H:/Vivado/VivadoProject/SingleCPU/SingleCPU.srcs/sources_1/new/CPU.v
    }
      rt::filesetChecksum
    }
    rt::set_parameter usePostFindUniquification false
    set rt::top CPU
    set rt::reportTiming false
    rt::set_parameter elaborateOnly false
    rt::set_parameter elaborateRtl false
    rt::set_parameter eliminateRedundantBitOperator true
    rt::set_parameter writeBlackboxInterface true
    rt::set_parameter ramStyle auto
    rt::set_parameter merge_flipflops true
    rt::set_parameter enableSplitFlowPath "./.Xil/Vivado-14852-LAPTOP-0H77ONJ6/"
    if {$rt::useElabCache == false} {
      rt::run_synthesis -module $rt::top
    }

    set rt::flowresult [ source $::env(SYNTH_COMMON)/flow.tcl ]
    if { $rt::flowresult == 1 } { return -code error }

    if { [ info exists ::env(RT_TMP) ] } {
      file delete -force $::env(RT_TMP)
    }


    source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  } ; #end uplevel
} rt::result]

if { $rt::rc } {
  return -code "error" $rt::result
}