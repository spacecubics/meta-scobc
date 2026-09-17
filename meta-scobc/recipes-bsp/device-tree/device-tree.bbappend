FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# Select the QSPI memory population by board revision and grade.
#   Rev.A Space/Developer -> scobc-v1-reva/qspi.dtsi
#   Rev.B Space           -> scobc-v1-revb/qspi.dtsi
#   Rev.B Developer       -> scobc-v1-revb/qspi-devgrade.dtsi
SCOBC_V1_QSPI_DTSI:scobc-v1-reva = "qspi.dtsi"
SCOBC_V1_QSPI_DTSI:scobc-v1-revb = "qspi.dtsi"
SCOBC_V1_QSPI_DTSI:scobc-v1-revb:scobc-v1-devgrade = "qspi-devgrade.dtsi"

# Apply the QSPI description to the PLM device tree.
EXTRA_DT_INCLUDE_FILES:append:microblaze-pmc:scobc-v1-generic = " ${SCOBC_V1_QSPI_DTSI}"

# Apply the SC-OBC Module V1 peripheral descriptions to Linux.
EXTRA_DT_INCLUDE_FILES:append:linux:scobc-v1-generic = " \
    bootargs.dtsi \
    usb.dtsi \
    ethernet.dtsi \
    ${SCOBC_V1_QSPI_DTSI} \
    reset.dtsi \
    rpu-peripherals.dtsi \
"

# Add the OpenAMP description only when OpenAMP is enabled.
EXTRA_DT_INCLUDE_FILES:append:linux:scobc-v1-generic = " \
    ${@' openamp.dtsi' if bb.utils.to_boolean(d.getVar('ENABLE_OPENAMP'), False) else ''} \
"

DT_INCLUDE:append:linux = "${@ \
    ' ${RECIPE_SYSROOT}${datadir}/sdt/${MACHINE}/include' \
    if bb.utils.to_boolean(d.getVar('ENABLE_OPENAMP'), False) else '' \
}"
