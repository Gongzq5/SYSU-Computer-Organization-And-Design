@echo off
rem  Vivado(TM)
rem  compile.bat: a Vivado-generated XSim simulation Script
rem  Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.

set PATH=%XILINX%\lib\%PLATFORM%;%XILINX%\bin\%PLATFORM%;H:/Vivado/Vivado/Vivado/2014.2/ids_lite/ISE/bin/nt64;H:/Vivado/Vivado/Vivado/2014.2/ids_lite/ISE/lib/nt64;H:/Vivado/Vivado/Vivado/2014.2/bin;%PATH%
set XILINX_PLANAHEAD=H:/Vivado/Vivado/Vivado/2014.2

xelab -m64 --debug typical --relax -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot Multi_sim_behav --prj H:/Vivado/VivadoProject/MultiCPU/MultiCPU.sim/sim_1/behav/Multi_sim.prj   xil_defaultlib.Multi_sim   xil_defaultlib.glbl
if errorlevel 1 (
   cmd /c exit /b %errorlevel%
)
