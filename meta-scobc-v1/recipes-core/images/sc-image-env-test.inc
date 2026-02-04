DESCRIPTION = "An image containing the development set of packages for SC-OBC Module V1"
LICENSE = "MIT"

require sc-image-common.inc

IMAGE_FSTYPES:append = " wic wic.bmap wic.xz"

IMAGE_INSTALL:append = " \
    mmc-utils \
    libgpiod \
    libgpiod-tools \
    python3-gpiod \
    stress-ng \
    perf \
    spitools \
    i2c-tools \
    can-utils \
    sysbench \
    lmbench \
    phoronix-test-suite \
    fio \
    "

IMAGE_INSTALL:append = " \
    kernel-module-sc-mipi-csi-driver \
    i2c-tools \
    v4l-utils \
"


INHERIT += "extrausers"

EXTRA_USERS_PARAMS = "\
    usermod -p '\$6\$Llu5WHMsbUGe42lz\$7M0gfTkD7Q/hnsPp8DvJE40yFPYS.oa3ss2tEQSNIjwrh6stFnYS2NGFM3g6tuJlnz8JChXBDV/oyhfnqqMHQ.' root; \
    "
