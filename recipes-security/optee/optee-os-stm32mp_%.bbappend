FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " file://0001-Add-stm32mp157c-odyssey-device-tree-based-on-dk2.patch \
             file://0002-stm32mp157c-odyssey-pmic-on-i2c2.patch \
             file://0003-fix-change-VCO-from-594MHz-to-750MHz-for-eth-phy.patch \
            "
