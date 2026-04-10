DESCRIPTION = "OSL image definition for SC-OBC Module V1"
LICENSE = "MIT"

require sc-image-common.inc

IMAGE_NAME_SUFFIX ?= ""
IMAGE_FSTYPES:append = " wic wic.xz wic.bmap"

IMAGE_INSTALL:append = " \
    ${@' xilinx-fpd-watchdogd' if bb.utils.to_boolean(d.getVar('ENABLE_XILINX_FPD_WWDT'), False) else ''} \
"
