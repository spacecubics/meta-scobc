FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://scobc-v1.cfg \
    file://0001-mtd-spi-nor-sfdp-introduce-smpt_read_dummy-fixup-hoo.patch \
    file://0002-mtd-spi-nor-sfdp-introduce-smpt_map_id-fixup-hook.patch \
    file://0003-mtd-spi-nor-spansion-SMPT-fixups-for-S25FS-S.patch \
    file://0004-mtd-spi-nor-spansion-Fix-warning.patch \
    file://0001-spi-zynqmp-gqspi-Fix-independent-chip-select-handli.patch \
    file://0001-dt-bindings-mtd-Add-CY15V108QSN-F-RAM.patch \
    file://0002-mtd-spi-nor-spansion-Add-CY15V108QSN-support.patch \
    file://0001-dt-bindings-mtd-Add-Avalanche-MRAM-compatibles.patch \
    file://0002-mtd-spi-nor-Add-Avalanche-MRAM-support.patch \
    file://0001-dt-bindings-mtd-Add-EM064LXQ-compatible.patch \
    file://0002-mtd-spi-nor-everspin-Add-EM064LXQ-support.patch \
    file://0001-rtc-zynqmp-Do-not-use-DT-calibration-value-as-RTC-fr.patch \
    file://0002-rtc-zynqmp-Always-program-Max_Tick-and-preserve-frac.patch \
    "

SRC_URI:append = " \
    ${@'file://xilinx-wwdt.cfg' if bb.utils.to_boolean(d.getVar('ENABLE_XILINX_FPD_WWDT'), False) else ''} \
"

SRC_URI:append = " \
    ${@' file://container.cfg' if bb.utils.to_boolean(d.getVar('ENABLE_CONTAINER'), False) else ''} \
"

SRC_URI:append = " \
    ${@' file://scobc-v1-openamp.cfg' if bb.utils.to_boolean(d.getVar('ENABLE_OPENAMP'), False) else ''} \
"
