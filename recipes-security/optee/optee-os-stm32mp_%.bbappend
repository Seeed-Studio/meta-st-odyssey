FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# OP-TEE has no Odyssey devicetree: add one (DK2 SoM, STPMIC1 on I2C2 instead of I2C4),
# register the I2C2 clock as non-secure so OP-TEE can drive the PMIC, and add the 512M
# DDR flavor.
SRC_URI += "file://0001-stm32mp157c-odyssey-optee-dt.patch"

# non-secure I2C clocks (I2C2 for the PMIC) are only registered with this switch
EXTRA_OEMAKE:append = " CFG_WITH_NSEC_I2CS=y"
