FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://${LINUX_VERSION}/${LINUX_VERSION}${LINUX_SUBVERSION}/0001-fix-stm32mp157c-odyssey-bootup.patch \
            file://${LINUX_VERSION}/${LINUX_VERSION}${LINUX_SUBVERSION}/0002-fix-change-VCO-from-594MHz-to-750MHz-for-eth-phy.patch \
            file://${LINUX_VERSION}/${LINUX_VERSION}${LINUX_SUBVERSION}/0003-stm32mp157c-odyssey-supports-usb-host.patch \
            "
