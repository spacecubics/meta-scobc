DESCRIPTION = "OSL image definition for SC-OBC Module V1"
LICENSE = "MIT"

require sc-image-dev.inc
require sc-image-container.inc

IMAGE_NAME_SUFFIX ?= ""
IMAGE_FSTYPES:append = " wic wic.xz wic.bmap"
