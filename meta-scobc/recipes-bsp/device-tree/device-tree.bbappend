FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

EXTRA_DT_INCLUDE_FILES:append:microblaze-pmc:scobc-v1-generic = " qspi.dtsi"

EXTRA_DT_INCLUDE_FILES:append:linux:scobc-v1-generic = " \
    bootargs.dtsi \
    usb.dtsi \
    ethernet.dtsi \
    qspi.dtsi \
    reset.dtsi \
    rpu-peripherals.dtsi \
"

EXTRA_DT_INCLUDE_FILES:append:linux:scobc-v1-generic = " \
    ${@' openamp.dtsi' if bb.utils.to_boolean(d.getVar('ENABLE_OPENAMP'), False) else ''} \
"

DT_INCLUDE:append:linux = "${@ \
    ' ${RECIPE_SYSROOT}${datadir}/sdt/${MACHINE}/include' \
    if bb.utils.to_boolean(d.getVar('ENABLE_OPENAMP'), False) else '' \
}"
