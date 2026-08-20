SUMMARY = "SC-OBC initramfs RAM-root switch module"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://ramroot"

S = "${WORKDIR}"

RDEPENDS:${PN} += "plnx-initramfs-framework-base"

do_install() {
    install -d ${D}/init.d
    install -m 0755 ${WORKDIR}/ramroot ${D}/init.d/89-ramroot
}

FILES:${PN} = "/init.d/89-ramroot"
