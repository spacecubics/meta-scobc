FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
    file://0001-sw_services-xilloader-Add-a-4-Gbit-flash-size-defini.patch \
    file://0002-sw_services-xilloader-Add-Avalanche-Dual-Quad-MRAM-s.patch \
"
