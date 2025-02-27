FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " file://0001-stm32mp1-supports-i2c2.patch \
             file://0002-fix-change-VCO-from-594MHz-to-750MHz-for-eth-phy.patch \
            "
