FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " file://0001-supports-stm32mp157c-odyssey.patch \
             file://0002-fix-change-VCO-from-594MHz-to-750MHz-for-eth-phy.patch \
            "
