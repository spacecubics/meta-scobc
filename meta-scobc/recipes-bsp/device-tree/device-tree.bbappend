FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SCOBC_V1_PLM_QSPI_DTSI = "${@ \
    'qspi.dtsi' if d.getVar('ESW_MACHINE') == 'psv_pmc_0' else '' \
}"

EXTRA_DT_INCLUDE_FILES:append = " ${SCOBC_V1_PLM_QSPI_DTSI}"

EXTRA_DT_INCLUDE_FILES:append:linux = " \
    bootargs.dtsi \
    usb.dtsi \
    ethernet.dtsi \
    qspi.dtsi \
    reset.dtsi \
    rpu-peripherals.dtsi \
"

EXTRA_DT_INCLUDE_FILES:append:linux = " \
    ${@' openamp.dtsi' if bb.utils.to_boolean(d.getVar('ENABLE_OPENAMP'), False) else ''} \
"

DT_INCLUDE:append:linux = "${@ \
    ' ${RECIPE_SYSROOT}${datadir}/sdt/${MACHINE}/include' \
    if bb.utils.to_boolean(d.getVar('ENABLE_OPENAMP'), False) else '' \
}"
