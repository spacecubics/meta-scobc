FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
    file://config.conf.in \
"

HAWKBIT_SERVER_ADDRESS ?= "10.10.0.254:8080"
HAWKBIT_TENANT_ID ?= "DEFAULT"
HAWKBIT_TARGET_NAME ?= "test-target"
HAWKBIT_AUTH_TOKEN ?= "cb115a721af28f781b493fa467819ef5"

do_install:append() {
    install -d ${D}${sysconfdir}/${PN}

    sed \
        -e "s/@@HAWKBIT_SERVER_ADDRESS@@/${HAWKBIT_SERVER_ADDRESS}/g" \
        -e "s/@@HAWKBIT_TENANT_ID@@/${HAWKBIT_TENANT_ID}/g" \
        -e "s/@@HAWKBIT_TARGET_NAME@@/${HAWKBIT_TARGET_NAME}/g" \
        -e "s/@@HAWKBIT_AUTH_TOKEN@@/${HAWKBIT_AUTH_TOKEN}/g" \
        ${WORKDIR}/config.conf.in > ${WORKDIR}/config.conf

    install -m 0644 ${WORKDIR}/config.conf \
        ${D}${sysconfdir}/${PN}/config.conf
}

SYSTEMD_AUTO_ENABLE:${PN} = "enable"
