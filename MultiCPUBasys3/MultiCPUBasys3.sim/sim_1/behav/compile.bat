@echo off
rem  Vivado(TM)
rem  compile.bat: a Vivado-generated XSim simulation Script
rem  Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.

set PATH=%XILINX%\lib\%PLATFORM%;%XILINX%\bin\%PLATFORM%;H:/Vivado/Vivado/Vivado/2014.2/ids_lite/ISE/bin/nt64;H:/Vivado/Vivado/Vivado/2014.2/ids_lite/ISE/lib/nt64;H:/Vivado/Vivado/Vivado/2014.2/bin;%PATH%
set XILINX_PLANAHEAD=H:/Vivado/Vivado/Vivado/2014.2

xelab -m64 --debug typical --relax -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot simForFPGA_behav --prj H:/Vivado/VivadoProject/MultiCPUBasys3/MultiCPUBasys3.sim/sim_1/behav/simForFPGA.prj   xil_defaultlib.simForFPGA   xil_defaultlib.glbl
if errorlevel 1 (
   cmd /c exit /b %errorlevel%
)
