FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI:append = " \
	file://config_fpd_wdt.cdo \
"

BIF_CDO_PARTITIONS:append = " fpd-wdt-cdo"

# Since DEPENDS is auto-populated from BIF_PARTITION_ATTR,
# explicitly remove it to avoid an invalid dependency.
DEPENDS:remove = "fpd-wdt-cdo"

BIF_PARTITION_ATTR[fpd-wdt-cdo]  = "type=cdo"
BIF_PARTITION_ID[fpd-wdt-cdo]    = "0x1c000000"
BIF_PARTITION_IMAGE[fpd-wdt-cdo] = "${WORKDIR}/config_fpd_wdt.cdo"
