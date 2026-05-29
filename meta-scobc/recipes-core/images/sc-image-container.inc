ENABLE_CONTAINER ?= "0"
ENABLE_DOCKER ?= "0"
ENABLE_PODMAN ?= "0"

python __anonymous() {
    enable_docker = bb.utils.to_boolean(d.getVar("ENABLE_DOCKER"), False)
    enable_podman = bb.utils.to_boolean(d.getVar("ENABLE_PODMAN"), False)

    if enable_docker and enable_podman:
        bb.fatal("ENABLE_DOCKER and ENABLE_PODMAN are mutually exclusive. Enable only one container runtime.")
}

WKS_FILES = "${@'sc-container-sd.wks' if bb.utils.to_boolean(d.getVar('ENABLE_CONTAINER'), False) else 'xilinx-default-sd.wks'}"

IMAGE_INSTALL:append = " \
    ${@' docker-moby' if bb.utils.to_boolean(d.getVar('ENABLE_DOCKER'), False) else ''} \
    ${@' podman slirp4netns fuse-overlayfs shadow' if bb.utils.to_boolean(d.getVar('ENABLE_PODMAN'), False) else ''} \
"
