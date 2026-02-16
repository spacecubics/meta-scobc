SUMMARY = "data partition setup scripts for dual boot systems"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI = " \
    file://data-tempfiles.conf \
"

do_install() {
    install -d ${D}${nonarch_libdir}/tmpfiles.d
    install -m 0644 ${WORKDIR}/data-tempfiles.conf ${D}${nonarch_libdir}/tmpfiles.d/data-tempfiles.conf
}

FILES:${PN} += " \
    ${nonarch_libdir}/tmpfiles.d/data-tempfiles.conf \
"
