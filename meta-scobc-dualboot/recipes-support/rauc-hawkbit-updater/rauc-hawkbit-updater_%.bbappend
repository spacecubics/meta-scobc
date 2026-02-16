FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
    file://config.conf \
"

do_install:append() {
    install -m 0644 ${WORKDIR}/config.conf \
        ${D}${sysconfdir}/${PN}/config.conf
}

SYSTEMD_AUTO_ENABLE:${PN} = "enable"
