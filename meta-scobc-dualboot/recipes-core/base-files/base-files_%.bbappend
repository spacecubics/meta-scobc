FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
    file://fstab.data.append \
"

do_install:append() {
    install -d ${D}/srv/data/artifacts
    cat ${WORKDIR}/fstab.data.append >> ${D}${sysconfdir}/fstab
}
