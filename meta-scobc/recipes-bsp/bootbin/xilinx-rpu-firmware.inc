# Add a lockstep RPU firmware ELF to the Versal application image.
RPU_FIRMWARE_URI ??= ""
RPU_FIRMWARE_SHA256 ??= "${@ \
    d.getVarFlag('RPU_FIRMWARE_URI', 'sha256sum') or '' \
}"
RPU_FIRMWARE_IMAGE_ID ?= "0x1c000000"

RPU_FIRMWARE_SRC_URI = "${@'%s;name=rpu-firmware' % d.getVar('RPU_FIRMWARE_URI') if d.getVar('RPU_FIRMWARE_URI') else ''}"

SRC_URI += " ${RPU_FIRMWARE_SRC_URI}"
SRC_URI[rpu-firmware.sha256sum] = "${RPU_FIRMWARE_SHA256}"

BIF_RPU_PARTITIONS:append = " rpu-firmware"

DEPENDS:remove = "rpu-firmware"

BIF_PARTITION_ATTR[rpu-firmware] = "core=r5-lockstep"
BIF_PARTITION_IMAGE[rpu-firmware] = "${@bb.fetch2.localpath(d.getVar('RPU_FIRMWARE_SRC_URI'), d)}"
BIF_PARTITION_ID[rpu-firmware] = "${RPU_FIRMWARE_IMAGE_ID}"

python __anonymous() {
    if not d.getVar("RPU_FIRMWARE_URI"):
        bb.fatal("RPU_FIRMWARE_URI must be specified")
}
