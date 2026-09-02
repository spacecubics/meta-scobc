FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

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
