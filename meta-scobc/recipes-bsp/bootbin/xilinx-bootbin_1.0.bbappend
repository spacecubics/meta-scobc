# Partition list is split into logical groups to allow modular extension.
# Optional components such as CDOs and RPU firmware can be added via :append
# without redefining the entire BIF_PARTITION_ATTR.
BIF_CDO_PARTITIONS = ""
BIF_APU_PARTITIONS = "${BIF_DEVICETREE_ATTR} ${BIF_ATF_ATTR} ${BIF_SSBL_ATTR}"
BIF_RPU_PARTITIONS = ""
BIF_EXTRA_PARTITIONS = ""

BIF_PARTITION_ATTR:versal = "\
    ${BIF_FSBL_ATTR} \
    ${BIF_CDO_PARTITIONS} \
    ${BIF_APU_PARTITIONS} \
    ${BIF_RPU_PARTITIONS} \
    ${BIF_EXTRA_PARTITIONS} \
"
