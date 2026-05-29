DESCRIPTION = "OSL image definition for SC-OBC Module V1"
LICENSE = "MIT"

require sc-image-dev.inc

ENABLE_CONTAINER ?= "0"
WKS_FILES = "${@'sc-container-sd.wks' if bb.utils.to_boolean(d.getVar('ENABLE_CONTAINER'), False) else 'xilinx-default-sd.wks'}"

IMAGE_NAME_SUFFIX ?= ""
IMAGE_FSTYPES:append = " wic wic.xz wic.bmap"

IMAGE_INSTALL:append = " \
    ${@' xilinx-fpd-watchdogd' if bb.utils.to_boolean(d.getVar('ENABLE_XILINX_FPD_WWDT'), False) else ''} \
"
