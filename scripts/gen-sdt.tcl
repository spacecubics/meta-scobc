# TCL script to generate System DeviceTree (SDT)
#
# Usage: sdtgen scripts/gen-sdt.tcl sc_obc_v1_versal.xsa meta-scobc-v1/recipes-bsp/sdt/files/versal-scobc-v1-sdt

set xsa [lindex $argv 0]
set outdir [lindex $argv 1]
exec rm -rf $outdir

set_dt_param -debug enable
set_dt_param -dir $outdir
set_dt_param -xsa $xsa
generate_sdt
