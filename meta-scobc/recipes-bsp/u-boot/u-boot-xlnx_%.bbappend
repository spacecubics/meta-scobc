require u-boot-elf-install-fix.inc
require u-boot-extra-cfgs.inc

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI:append = " \
    file://0001-net-phy-dp83867-Write-only-SW_RESTART-when-restartin.patch \
    file://0001-spi-zynqmp-gqspi-Select-independent-upper-chip-sele.patch \
    file://0001-mtd-spi-nor-Add-CY15V108QSN-F-RAM-support.patch \
    file://0001-mtd-spi-nor-Add-Avalanche-Dual-Quad-MRAM-support.patch \
    file://0001-mtd-spi-nor-Add-EM064LXQ-MRAM-support.patch \
"

UBOOT_EXTRA_CFGS += " \
    scobc-v1.cfg \
"
