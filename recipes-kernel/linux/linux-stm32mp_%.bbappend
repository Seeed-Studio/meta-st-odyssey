FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# Seeed Odyssey-STM32MP157C on the OpenSTLinux secure flow (TF-A -> OP-TEE -> U-Boot -> Linux).
# 0001  SCMI clock/reset overlay (OP-TEE owns the clocks in this flow)
# 0002  Ethernet: MAC-level PHY reset with 50 ms settle, drop broken assigned-clocks, rgmii
# 0003  USB host: usbphyc/EHCI/OHCI/OTG, VBUS switches, PHY supplies and tuning
# 0004  WiFi/BT (AP6236): SDIO on sdmmc3, BT on usart1, RTC LSCO 32 kHz clock, serial1 alias
SRC_URI += " \
    file://${LINUX_VERSION}/${LINUX_VERSION}${LINUX_SUBVERSION}/0001-ARM-dts-stm32-add-SCMI-variant-for-stm32mp157c-odysse.patch \
    file://${LINUX_VERSION}/${LINUX_VERSION}${LINUX_SUBVERSION}/0002-ARM-dts-stm32mp157c-odyssey-ethernet.patch \
    file://${LINUX_VERSION}/${LINUX_VERSION}${LINUX_SUBVERSION}/0003-ARM-dts-stm32mp157c-odyssey-usb-host.patch \
    file://${LINUX_VERSION}/${LINUX_VERSION}${LINUX_SUBVERSION}/0004-ARM-dts-stm32mp157c-odyssey-wifi-bt.patch \
    file://odyssey/fragment-80-usb-bluetooth.config;subdir=fragments \
"

# btusb for USB Bluetooth dongles (ST's config only has their UART-attached BT)
KERNEL_CONFIG_FRAGMENTS:append = " ${WORKDIR}/fragments/odyssey/fragment-80-usb-bluetooth.config"
