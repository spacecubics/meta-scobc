FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# Board hardware descriptions are supplied by the generated SDT.
# Keep Linux boot policy and RPU peripheral assignments here.
EXTRA_DT_INCLUDE_FILES:append:linux:scobc-v1-generic = " \
    bootargs.dtsi \
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
