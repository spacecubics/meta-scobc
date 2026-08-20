DESCRIPTION = "Development RAM-root filesystem image for Space Cubics platforms"
LICENSE = "MIT"

require sc-image-dev.inc

IMAGE_NAME_SUFFIX ?= ""
IMAGE_FSTYPES = "${INITRAMFS_FSTYPES}"

INITRAMFS_SCRIPTS ?= " \
    plnx-initramfs-framework-base \
    sc-initramfs-module-ramroot \
"

IMAGE_INSTALL:append = " \
    ${INITRAMFS_SCRIPTS} \
"

# This image is used as the final RAM-root filesystem rather than as a
# small, temporary early-userspace initramfs. Its package set therefore
# exceeds Yocto's default INITRAMFS_MAXSIZE of 128 MiB.
INITRAMFS_MAXSIZE = "327680"
