SUMMARY = "Inotify-based directory watcher service"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "\
    file://watch-rauc-bundle.sh \
    file://watch-rauc-bundle.service \
"

S = "${WORKDIR}"

RDEPENDS:${PN} += " \
    boot-slot-switch \
    inotify-tools \
"

do_install() {
    install -d ${D}${sbindir}
    install -m 0755 ${WORKDIR}/watch-rauc-bundle.sh ${D}${sbindir}/watch-rauc-bundle.sh

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/watch-rauc-bundle.service ${D}${systemd_system_unitdir}/watch-rauc-bundle.service
}

FILES:${PN} += " \
    ${sbindir}/watch-rauc-bundle.sh \
    ${systemd_system_unitdir}/watch-rauc-bundle.service \
"

inherit systemd

SYSTEMD_SERVICE:${PN} = "watch-rauc-bundle.service"
SYSTEMD_AUTO_ENABLE:${PN} = "enable"
